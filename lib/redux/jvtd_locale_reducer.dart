import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
//本地语言reducer

///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
final JvtdLocaleReducer = combineReducers<Locale>([
  ///将Action，处理Action动作的方法，State绑定
  TypedReducer<Locale, RefreshLocaleAction>(_refresh),
]);

///定义处理 Action 行为的方法，返回新的 State
Locale _refresh(Locale locale, action) {
  locale = action.locale;
  return locale;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshLocaleAction {
  final Locale locale;
  RefreshLocaleAction(this.locale);
}