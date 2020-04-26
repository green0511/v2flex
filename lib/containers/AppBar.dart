import 'package:flutter/material.dart';
import 'package:v2flex/pages/user.dart';

PreferredSize renderAppBar () {
  return PreferredSize(
    preferredSize: Size.fromHeight(72),
    child: AppBar(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
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
        Avatar(),
      ],
    ),
  );
}

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserRoute()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(36),
          ),
        ),
      )
    );
  }
}
