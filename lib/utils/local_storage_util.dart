import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

//本地存储
class LocalStorage {
  /// 保存本地信息
  /// key 键
  /// value 值
  static save({@required String key, value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  /// 获取本地保存信息
  /// key 键
  static get({@required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  /// 删除本地保存信息
  /// key 键
  static remove({@required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
}
