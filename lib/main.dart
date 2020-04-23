import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './model.dart';
import './api.dart';

import './containers/AppBar.dart';
import './containers/TabBar.dart';
import './containers/ItemList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  DefaultTabController(
        length: 10,
        child: Scaffold(
          appBar: renderAppBar(),
          body: Container(
            color: Color.fromARGB(255, 240, 240, 240),
            child: Column(
              children: <Widget>[
                renderTabBar(),
                Expanded(
                  child: FutureBuilder<List<ItemSummary>>(
                    future: fetchItems(http.Client()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);

                      return snapshot.hasData
                        ? ItemsList(items: snapshot.data)
                        : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


