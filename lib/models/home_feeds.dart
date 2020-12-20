import 'package:v2flex/models/topic.dart';

class TabData {
  // expired in 60 seconds
  static int expireDuration = 1000 * 5;

  bool isRefreshing = false;

  List<Topic> topicList = [];

  DateTime lastUpdateTime;

  TabData() : lastUpdateTime = DateTime.now();

  setList(List<Topic> newList) {
    topicList = newList;
    lastUpdateTime = DateTime.now();
  }

  hasExpire() {
    return lastUpdateTime.millisecondsSinceEpoch + expireDuration <=
        DateTime.now().millisecondsSinceEpoch;
  }
}
