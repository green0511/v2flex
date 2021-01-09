import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// class StorageKeys {
//   static const String TABS = 'TABS';
// }

enum StorageKeys {
  tabs,
}

String mapKeyToString(StorageKeys storeKey) {
  return storeKey.toString().split('.').last;
}

class Storage {
  static Future<T> getItem<T>(StorageKeys storeKey) async {
    String storeKeyString = mapKeyToString(storeKey);
    T result;

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedTabsString = prefs.getString(storeKeyString ?? '');

      if (storedTabsString?.isNotEmpty ?? false) {
        result = jsonDecode(storedTabsString) as T;
      }
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(storeKeyString);

      print(e);
    }

    return result;
  }

  static Future<bool> setItem(StorageKeys storeKey, String value) async {
    String storeKeyString = mapKeyToString(storeKey);

    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(storeKeyString ?? '', value);
    } catch (e) {
      return false;
    }
  }
}
