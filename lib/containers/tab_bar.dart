import 'package:flutter/material.dart';
import 'package:v2flex/models/models.dart';

Widget renderTabBar(List<V2Tab> tabs, TabController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: TabBar(
      controller: controller,
      indicatorColor: Color.fromARGB(255, 247, 219, 34),
      indicatorPadding: EdgeInsets.only(left: 22, right: 22),
      indicatorWeight: 3,
      labelPadding: EdgeInsets.all(0),
      labelColor: Colors.black87,
      isScrollable: true,
      tabs: tabs
          .map((tab) => (Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                height: 36,
                color: Color.fromARGB(255, 240, 240, 240),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    tab.name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )))
          .toList(),
    ),
  );
}
