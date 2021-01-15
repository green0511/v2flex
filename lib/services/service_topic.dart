import 'dart:async';
import 'dart:convert';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'package:v2flex/models/models.dart';
import 'package:v2flex/utils/http_client.dart';
import './parsers/parsers.dart';

Future<TopicDetail> fetchTopicDetail(String id) async {
  final htmlRepose = await dio.get('/t/$id');
  Document document = parse(htmlRepose.data);
  TopicDetail topicDetail = parseDetail(document, id: int.tryParse(id));

  // final response = await dio.get('/api/topics/show.json?id=$id');

  // var data = response.data;
  // var json = data.runtimeType == String ? jsonDecode(data) : data;
  // var topicJson = json[0];

  // TopicDetail topicDetail = TopicDetail.fromJson(topicJson);
  return topicDetail;
}
