/*
# @Time : 4/7/21 3:04 PM 
# @Author : 湛
# @File : LZStorageUtils.py
# @Desc : ==============================================
# 打工赚不了几个钱,但打工能让你没时间花钱。
#      ┌─┐       ┌─┐
#   ┌──┘ ┴───────┘ ┴──┐
#   │       ───       │
#   │  ─┬┘       └┬─  │
#   │       ─┴─       │
#   └───┐         ┌───┘
#       │         │
#       │         └──────────────┐
#       │                        ├─┐
#       │                        ┌─┘
#       └─┐  ┐  ┌───────┬──┐  ┌──┘
#         │ ─┤ ─┤       │ ─┤ ─┤
#         └──┴──┘       └──┴──┘
#                神兽保佑
#               代码无BUG!
# ======================================================
*/

//数据本地化工具

import 'dart:convert' as convert;

// aes 加密存储
import 'package:flustars/flustars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LZEncryptUtils.dart';

class LZStorageUtils {
  //存 String
  static Future<bool> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    key = LZEncryptUtils.aesEncrypt(key);
    value = LZEncryptUtils.aesEncrypt(value);
    return prefs.setString(key, value);
  }

  //取 String
  static Future<String> getStringWithKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    key = LZEncryptUtils.aesEncrypt(key);
    var enValue = await prefs.getString(key);
    if (enValue == null) {
      return null;
    } else {
      if (enValue.length > 0) {
        return LZEncryptUtils.aesDecrypt(enValue);
      }
      return enValue;
    }
  }

  //存 bool
  static Future<bool> saveBool(String key, bool value) {
    var newValue = value == true ? "TRUE" : "FALSE";
    return saveString(key, newValue);
  }

  //取 bool
  static bool getBoolWithKey(String key) {
    var value = getStringWithKey(key);
    return value == "TRUE" ? true : false;
  }

  //存 int
  static Future<bool> saveInt(String key, int value) {
    var newValue = value.toString();
    return saveString(key, newValue);
  }

  //取 int
  static Future<int> getIntWithKey(String key) async {
    var value = await getStringWithKey(key);
    value = value == '' ? '0' : value;
    return int.parse(value);
  }

  //存 double
  static Future<bool> saveDouble(String key, double value) {
    var newValue = value.toString();
    return saveString(key, newValue);
  }

  //取 double
  static Future<double> getDoubleWithKey(String key) async {
    var value = await getStringWithKey(key);
    value = value == '' ? '0' : value;
    return double.parse(value);
  }

  //存 Model
  static Future<bool> saveModel(String key, Object model) {
    String jsonString = convert.jsonEncode(model);
    print(jsonString);
    return saveString(key, jsonString);
  }

  //取 Model
  static Future<Map> getModelWithKey(String key) async {
    var jsonString = await getStringWithKey(key);
    print('取到的数据哈哈哈===>>>>${jsonString}');
    return (jsonString == null || jsonString.isEmpty)
        ? null
        : convert.jsonDecode(jsonString);
  }

  //移除
  static Future<bool> removeWithKey(String key) {
    key = LZEncryptUtils.aesEncrypt(key);
    return SpUtil.remove(key);
  }
}
