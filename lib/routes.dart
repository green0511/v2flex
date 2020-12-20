import 'package:flutter/material.dart';

import 'models/Topic.dart';
import 'pages/detail.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class NavigatorUtil {
  static void defaultOpen({Widget Function(BuildContext) builder}) {
    navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: builder,
      ),
    );
  }

  static void openTopicDetail(Topic topic) {
    defaultOpen(
      builder: (BuildContext context) {
        return PageDetail(
          topic: topic,
        );
      },
    );
  }
}
