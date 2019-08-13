import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

// toast 工具类
class JvtdToast {
  /// 显示信息
  /// msg 显示内容
  /// context 上下文
  /// toastGravity 显示位置 默认BOTTOM [CENTER/TOP/BOTTOM]
  /// toast 显示时长 默认 LENGTH_SHORT [LENGTH_SHORT（ios 1秒）/LENGTH_LONG（ios 2秒）]
  /// bgColor 背景颜色  默认黑色
  /// textColor 字体颜色  默认白色
  static void showMessage({
    @required String msg,
    @required BuildContext context,
    int toastGravity = 0,
    int toast = 0,
    Color bgColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    if (toastGravity == 0) {
      toastGravity = Toast.BOTTOM;
    }
    if (toast == 0) {
      toast = Toast.LENGTH_SHORT;
    }
    Toast.show(msg, context);
  }
}
