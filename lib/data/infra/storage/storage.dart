import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum StorageEnum { theme, language, temperatureUnit }

final class Storage {
  Future<void> save({
    required StorageEnum storage,
    required Map<String, dynamic> data,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(storage.name, jsonEncode(data));
  }

  Future<Map<String, dynamic>?> get(StorageEnum storageEnum) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(storageEnum.name);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  Future<void> clear(StorageEnum storageEnum) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(storageEnum.name);
  }

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var key in StorageEnum.values) {
      await prefs.remove(key.name);
    }
  }
}
