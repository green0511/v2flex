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
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        Topic item = items[index];

        return Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 18,
            bottom: 30,
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
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'detail',
                    arguments: {'item': item},
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(top: 13, bottom: 15, left: 13, right: 13),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 240, 240),
                      border: Border.all(
                        width: 1,
                        color: Colors.black87,
                      )),
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
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
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
                            Expanded(
                              child: Text(''),
                            ),
                            Text(
                              '${item.replyCount} 回复',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
