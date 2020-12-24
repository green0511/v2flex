import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:v2flex/models/v2_tab.dart';

class StorageKeys {
  static const String TABS = 'TABS';
}

Future<List<V2Tab>> getTabsFromStore() async {
  List<dynamic> jsonList = await getData<List<dynamic>>(StorageKeys.TABS) ?? [];

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
  return await saveData(StorageKeys.TABS, value);
}

Future<T> getData<T>(String storeKey) async {
  T result;

  try {
    final prefs = await SharedPreferences.getInstance();
    final storedTabsString = prefs.getString(storeKey ?? '');

    if (storedTabsString?.isNotEmpty ?? false) {
      result = jsonDecode(storedTabsString) as T;
    }
  } catch (e) {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(storeKey);

    print(e);
  }

  return result;
}

Future<bool> saveData(String storeKey, String value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(storeKey ?? '', value);
  } catch (e) {
    return false;
  }
}
