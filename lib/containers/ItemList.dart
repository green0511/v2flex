import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:v2flex/models/Models.dart';

class ItemsList extends StatelessWidget {
  final List<Topic> items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        Topic item = items[index];

        return Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 18,
            bottom: 20,
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: 8,
                left: 8,
                right: -8,
                bottom: -8,
                child: DottedBorder(
                  borderType: BorderType.Rect,
                  dashPattern: [6, 5, 6, 5],
                  color: Colors.black87,
                  strokeWidth: 1,
                  child: Container(),
                ),
                // child: Container(
                //   decoration: BoxDecoration(
                //     // color: Colors.red,
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.black87,
                //       style: BorderStyle.solid,
                //     )
                //   ),
                // ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 10, left: 13, right: 13),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240),
                  border: Border.all(
                    width: 1,
                    color: Colors.black87,
                  )
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 6),
                                        height: 16,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.all(Radius.circular(3)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            item.node.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item.author.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          // height: 1,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          item.lastTouchString,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        // widthFactor: 3,
                        child: FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 100,
                            height: 3,
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // IconTextButton('20 ups', Icons.arrow_upward),
                            IconTextButton('${item.replyCount} 回复', Icons.chat_bubble),
                            // IconTextButton('200 views', Icons.remove_red_eye),
                          ],
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

class IconTextButton extends StatelessWidget {
  final String text;
  final IconData iconData;

  IconTextButton(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   margin: EdgeInsets.only(right: 5),
          //   child: Icon(
          //     this.iconData,
          //     size: 16,
          //     color: Colors.black38,
          //   ),
          // ),
          Text(
            this.text,
            style: TextStyle(
              fontSize: 14,
              height: 1,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
