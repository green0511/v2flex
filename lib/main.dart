import 'package:flutter/material.dart';

import 'utils/http_client.dart';

import 'containers/HomeFeed.dart';
import 'containers/AppBar.dart';

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
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<Main> {
  int _currentIndex = 0;
  List<Widget> pages = [
    null,
    null,
  ];
  List getWidgetFns = [
    () => HomeFeed(),
    () => SecondContainer(),
  ];

  Widget get bodyWidget {
    return pages[_currentIndex] ?? Container();
  }

  @override
  void initState() {
    super.initState();
    _setPage(_currentIndex);
  }

  onTapNavigetionItem(int index) {
    _setPage(index);

    setState(() {
      _currentIndex = index;
    });
  }

  _setPage(int index) {
    if (pages[index] == null) {
      var fn = getWidgetFns[index];
      pages[index] = fn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: onTapNavigetionItem,
      ),
    );
  }
}

class SecondContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('test'),);
  }
}
