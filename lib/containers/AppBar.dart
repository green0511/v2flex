import 'package:flutter/material.dart';

PreferredSize renderAppBar () {
  return PreferredSize(
    preferredSize: Size.fromHeight(72),
    child: AppBar(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      elevation: 0,
      centerTitle: false,
      title: Text(
        'v2flex'.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 4,
        ),
      ),
      actions: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(right: 15),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(36),
            ),
          )
        ),
      ],
      bottom: TabBar(
        tabs: <Widget>[
        ],
      ),
    ),
  );
}
