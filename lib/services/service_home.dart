import 'dart:async';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'package:v2flex/models/models.dart';
import 'package:v2flex/services/storage.dart';
import 'package:v2flex/utils/http_client.dart';

import './parsers/parsers.dart';

Future<List<V2Tab>> getTabsFromStore() async {
  List<dynamic> jsonList = [];

  try {
    jsonList = await Storage.getItem<List<dynamic>>(StorageKeys.tabs) ?? [];
  } catch (e) {}

  return jsonList.map(
    (i) {
      return V2Tab(name: i['name'], id: i['id']);
    },
  ).toList();
}

Future<bool> saveTabsToStore(List<V2Tab> tabList) async {
  var value = tabList
      .map(
        (e) => e.toString(),
      )
      .toList()
      .toString();
  return await Storage.setItem(StorageKeys.tabs, value);
}

Future<dynamic> fetchIndex() async {
  // 无缓存数据。从首页初始化
  final response = await dio.get('/');
  Document document = parse(response.data);

  List<V2Tab> tabList = parseTabsFromIndexHTML(document);
  List<Topic> topicList = parseTopicFromIndexHTML(document);

  return {
    'tabList': tabList,
    'topicList': topicList,
  };
}

Future<List<Topic>> fetchTopicListInTab(V2Tab tab) async {
  final response = await dio.get('/', queryParameters: {
    'tab': tab.id,
  });
  Document document = parse(response.data);

  return parseTopicFromIndexHTML(document);
}
