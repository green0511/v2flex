import 'package:flutter/material.dart';
import 'package:v2flex/models/Topic.dart';

import './api.dart';

import './containers/AppBar.dart';
import './containers/TabBar.dart';
import './containers/ItemList.dart';

import 'package:v2flex/utils/http_client.dart';
import 'package:v2flex/api.dart';
import 'package:v2flex/models/HomeFeeds.dart';

void main() {
  initDio();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeApp(),
    );
  }
}

Widget renderTabView(
  List<V2Tab> tabs,
  Map<String, TabData> tabDataStore,
  TabController controller,
  RefreshCallback onRefresh,
  V2Tab currentTab,
) {
  return TabBarView(
    controller: controller,
    children: tabs.map((tab) {
      return SingleTabView(tab, tabDataStore, onRefresh, tab.id == currentTab.id);
    }).toList(),
  );
}

typedef RefreshCallback = Future<dynamic> Function(V2Tab tab, bool isForce);

class SingleTabView extends StatefulWidget {
  final V2Tab tab;
  final Map<String, TabData> tabDataStore;
  final RefreshCallback onRefresh;
  final bool isCurrent;

  SingleTabView(
    this.tab,
    this.tabDataStore,
    this.onRefresh,
    this.isCurrent,
  );

  @override
  _SingleTabViewState createState() => _SingleTabViewState();
}

class _SingleTabViewState extends State<SingleTabView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) {
          TabData tabData = widget.tabDataStore[widget.tab.id];
          int topicListLength = tabData?.topicList?.length ?? 0;
          if (topicListLength == 0) {
            return Center(child: CircularProgressIndicator());
          }

          if (tabData.hasExpire() && !tabData.isRefreshing && widget.isCurrent) {
            _refreshIndicatorKey.currentState?.show();
          }

          return RefreshIndicator(
            color: Colors.black87,
            key: _refreshIndicatorKey,
            child: ItemsList(items: tabData.topicList),
            onRefresh: () async {
              await widget.onRefresh(widget.tab, true);
            },
          );
        },
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeAppState();
  }
}

class HomeAppState extends State<HomeApp> with SingleTickerProviderStateMixin {

  List<V2Tab> tabs = [];
  Map<String, TabData> tabDataStore = {};

  TabController controller;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() {
    tabs = fetchTabs();

    controller = TabController(
      length: tabs.length,
      vsync: this,
    );

    controller.addListener(() => _onTabChanged());

    fetchTabData(tabs[_currentTabIndex]);
  }

  Future<void> fetchTabData(V2Tab tab, [bool isForce = false]) async {
    tabDataStore[tab.id] = tabDataStore[tab.id] ?? TabData();
    var currentTabData = tabDataStore[tab.id];

    if (currentTabData.topicList.length > 0 && !currentTabData.hasExpire() && !isForce) {
      // 已有数据并且没有过期，则不请求新数据
      return;
    }

    if (currentTabData.isRefreshing) return;

    setState(() {
      currentTabData.isRefreshing = true;
    });

    // print('fetching ${tab.name}');
    List<Topic> data = await fetchTab(tab);
    setState(() {
      currentTabData.setList(data);
      currentTabData.isRefreshing = false;
    });
  }

  _onTabChanged() {
    if (controller.index.toDouble() == controller.animation.value) { 
      //赋值 并更新数据
      this.setState(() {
        _currentTabIndex = controller.index;

        V2Tab tab = tabs[_currentTabIndex];
        if (tabDataStore[tab.id] == null) {
          fetchTabData(tabs[_currentTabIndex]);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
        color: Color.fromARGB(255, 240, 240, 240),
        child: Column(
          children: <Widget>[
            renderTabBar(tabs, controller),
            Expanded(
              child: renderTabView(
                tabs,
                tabDataStore,
                controller,
                fetchTabData,
                tabs[_currentTabIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
