import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 日期转换
class DateUtil {
  static const String YMDHMS = 'yyyy-MM-dd HH:mm:ss';
  static const String YMDHM = 'yyyy-MM-dd HH:mm';
  static const String YMD = 'yyyy-MM-dd';
  static const String HMS = 'HH:mm:ss';

  static const String DATE_LOCALE = 'zh';

  //当前时间格式
  static now({String format = YMDHMS}) {
    return long2String(millisecond: nowTimestamp(), format: format);
  }

  //当前时间戳
  static nowTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  //时间戳转换时间格式
  static long2String({@required int millisecond, String format = YMDHMS, String locale = DATE_LOCALE}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecond);
    DateFormat dateFormat = DateFormat(format, locale);
    return dateFormat.format(dateTime);
  }

  //时间格式转换时间戳
  static string2long({@required String date, String format = YMDHMS, String locale = DATE_LOCALE}) {
    DateFormat dateFormat = DateFormat(format, locale);
    DateTime dateTime = dateFormat.parse(date);
    return dateTime.millisecondsSinceEpoch;
  }

  //时间格式转时间格式
  static string2String({@required String date, String fromFormat = YMDHMS, String toFormat = YMD, String locale = DATE_LOCALE}) {
    DateFormat dateFormat = DateFormat(fromFormat, locale);
    DateTime dateTime = dateFormat.parse(date);
    DateFormat toDateFormat = DateFormat(toFormat, locale);
    return toDateFormat.format(dateTime);
  }
}
