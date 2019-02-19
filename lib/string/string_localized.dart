import 'dart:ui';
import 'package:flutter/material.dart';
//字符国际化
abstract class StringLocalized<T> {
  final Locale locale;

  StringLocalized(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///StringZh都继承了StringBase
  @protected
  Map<String, T> localizedValues();

  T get currentLocalized {
    return localizedValues()[locale.languageCode];
  }
}
