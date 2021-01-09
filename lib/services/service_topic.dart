import 'dart:async';
import 'dart:convert';

import 'package:v2flex/models/models.dart';
import 'package:v2flex/utils/http_client.dart';

Future<TopicDetail> fetchTopicDetail(String id) async {
  final response = await dio.get('/api/topics/show.json?id=$id');

  var data = response.data;
  var json = data.runtimeType == String ? jsonDecode(data) : data;
  var topicJson = json[0];

  TopicDetail topicDetail = TopicDetail.fromJson(topicJson);
  return topicDetail;
}
