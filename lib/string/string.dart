import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../redux/jvtd_state.dart';
import '../redux/jvtd_locale_reducer.dart';

export 'string_base.dart';
export 'string_en.dart';
export 'string_zh.dart';
export 'string_localized.dart';
export 'string_localized_delegate.dart';

enum StringType{
  ZH,
  EN,
}

class Strings{
  static const String ZH = 'zh';//中文
  static const String CH = 'CH';
  static const String EN = 'en';//英文
  static const String US = 'US';

  //切换语言包
  static void changeLocale(Store<JvtdState> store, StringType type) {
    Locale locale = store.state.platformLocale;
    switch (type) {
      case StringType.ZH:
        locale = Locale(Strings.ZH,Strings.CH);
        break;
      case StringType.EN:
        locale = Locale(Strings.EN,Strings.US);
        break;
    }
    store.dispatch(RefreshLocaleAction(locale));
  }
}