import 'package:flutter/material.dart';

import 'models/Topic.dart';
import 'pages/detail.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'detail': (context) {
    Map<String, Topic> arguments = ModalRoute.of(context).settings.arguments;
    return PageDetail(
      topic: arguments['item'],
    );
  },
};
