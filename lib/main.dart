import 'package:flutter/material.dart';

import 'routes.dart';
import 'utils/http_client.dart';

import 'containers/HomeFeed.dart';

void main() {
  initDio();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
      initialRoute: '/',
      routes: routes,
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
  PageController pageController = PageController();

  int _currentIndex = 0;

  List getWidgetFns = [
    () => HomeFeed(),
    () => Placeholder(),
    () => Placeholder(),
    () => Placeholder(),
  ];

  onTapNavigetionItem(int index) {
    setState(() {
      _currentIndex = index;
    });

    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        child: SafeArea(
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: pageController,
            itemCount: getWidgetFns.length,
            itemBuilder: (context, index) {
              return getWidgetFns[index]();
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '关注',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: onTapNavigetionItem,
      ),
    );
  }
}
