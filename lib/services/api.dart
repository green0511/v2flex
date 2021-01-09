import 'dart:async';
import 'dart:convert';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'package:v2flex/models/models.dart';
import 'package:v2flex/utils/http_client.dart';

import './parsers/parsers.dart';

List<V2Tab> fetchTabs() {
  return [
    V2Tab(name: '技术', id: 'tech'),
    V2Tab(name: '创意', id: 'creative'),
    V2Tab(name: '好玩', id: 'play'),
    V2Tab(name: 'Apple', id: 'apple'),
    V2Tab(name: '酷工作', id: 'jobs'),
    V2Tab(name: '交易', id: 'deals'),
    V2Tab(name: '城市', id: 'city'),
    V2Tab(name: '问与答', id: 'qna'),
    V2Tab(name: '最热', id: 'hot'),
    V2Tab(name: '全部', id: 'all'),
  ];
}

Future<List<Topic>> fetchTopicListInTab(V2Tab tab) async {
  final response = await dio.get('/', queryParameters: {
    'tab': tab.id,
  });
  Document document = parse(response.data);

  return parseTopicFromIndexHTML(document);
}

Future<TopicDetail> fetchTopicDetail(String id) async {
  final response = await dio.get('/api/topics/show.json?id=$id');

  var data = response.data;
  var json = data.runtimeType == String ? jsonDecode(data) : data;
  var topicJson = json[0];

  TopicDetail topicDetail = TopicDetail.fromJson(topicJson);
  return topicDetail;
}
