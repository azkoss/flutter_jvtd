import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// toast 工具类
class JvtdToast {
  //iOS对应Android吐司时长
  static const int IOS_LENGTH_SHORT = 1;
  static const int IOS_LENGTH_LONG = 2;

  /// 显示信息
  /// msg 显示内容
  /// toastGravity 显示位置 默认BOTTOM [CENTER/TOP/BOTTOM]
  /// toast 显示时长 默认 LENGTH_SHORT [LENGTH_SHORT（ios 1秒）/LENGTH_LONG（ios 2秒）]
  /// bgColor 背景颜色  默认黑色
  /// textColor 字体颜色  默认白色
  static Future<bool> showMessage({
    @required String msg,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    Toast toast = Toast.LENGTH_SHORT,
    Color bgColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    int iosTime; //iOS显示时长
    if (Platform.isAndroid) {
      bgColor = Colors.transparent;
    }
    if (toast == Toast.LENGTH_SHORT) {
      iosTime = IOS_LENGTH_SHORT;
    } else {
      iosTime = IOS_LENGTH_LONG;
    }
    return Fluttertoast.showToast(msg: msg, toastLength: toast, gravity: toastGravity, timeInSecForIos: iosTime, backgroundColor: bgColor, textColor: textColor);
  }
}
