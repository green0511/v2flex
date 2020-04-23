import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './model.dart';

Future<List<ItemSummary>> fetchItems(http.Client client) async {
  final response = await client.get('http://www.mocky.io/v2/5ea06b5a320000934394af09');
  print(response.body.length);
  return compute(parseItems, response.body);
}

List<ItemSummary> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ItemSummary>((json) => ItemSummary.fromJSON(json)).toList();
}