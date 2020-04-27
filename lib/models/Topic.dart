import 'package:v2flex/models/Node.dart';
import 'package:v2flex/models/SimpleMember.dart';

class Topic {
  String id;
  SimpleMember author;
  String title;
  int vote;
  V2Node node;

  String lastTouchString;
  SimpleMember lastTouchMember;
  int replyCount;

  String link;

  Topic({
    this.id,
    this.author,
    this.title,
    this.vote,
    this.node,
    this.lastTouchString,
    this.lastTouchMember,
    this.replyCount,
    this.link,
  });
}
