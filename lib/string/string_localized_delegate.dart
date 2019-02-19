import 'dart:async';
import 'package:flutter/material.dart';
import 'string_localized.dart';
import 'string.dart';
//多语言代理
abstract class StringLocalizedDelegate<T extends StringLocalized> extends LocalizationsDelegate<T> {
  StringLocalizedDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return [Strings.ZH, Strings.EN].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<T> load(Locale locale);

  @override
  bool shouldReload(LocalizationsDelegate<T> old) {
    return false;
  }
}
