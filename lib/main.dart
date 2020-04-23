import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './model.dart';
import './api.dart';

import './containers/AppBar.dart';
import './containers/TabBar.dart';

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
            color: Colors.white,
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

class ItemsList extends StatelessWidget {
  final List<ItemSummary> items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        ItemSummary item = items[index];

        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    item.member.avatarLarge,
                    width:48,
                    height:48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

