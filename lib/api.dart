import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './model.dart';

Future<List<ItemSummary>> fetchItems(http.Client client) async {
  final response = await client.get('http://www.mocky.io/v2/5ea311804f00006829d9f75e');
  print(response.body.length);
  return compute(parseItems, response.body);
}

List<ItemSummary> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ItemSummary>((json) => ItemSummary.fromJSON(json)).toList();
}

List<String> fetchTabs() {
  return [
    '技术',
    '创意',
    '好玩',
    'Apple',
    '酷工作',
    '交易',
    '城市',
    '问与答',
    '最热',
    '全部'
  ];
}
