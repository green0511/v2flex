import 'package:flutter/material.dart';

import 'package:v2flex/utils/http_client.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeFeed(),
    );
  }
}
