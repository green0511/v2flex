import 'package:flutter/material.dart';
import 'package:v2flex/api.dart';

Widget renderTabBar () {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: TabBar(
      indicatorColor: Color.fromARGB(255, 247, 219, 34),
      indicatorPadding: EdgeInsets.only(left: 22, right: 22),
      indicatorWeight: 3,
      labelPadding: EdgeInsets.all(0),
      labelColor: Colors.black87,
      isScrollable: true,
      tabs: fetchTabs()
        .map((tabName) => (
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            height: 36,
            color: Color.fromARGB(255, 240, 240, 240),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                tabName,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        )).toList(),
    ),
  );
}
