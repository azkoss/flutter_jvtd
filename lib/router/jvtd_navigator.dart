import 'package:flutter/material.dart';

class JvtdNavigator {
  static Future<bool> maybePop<T extends Object>(BuildContext context, [T result]) {
    return Navigator.maybePop<T>(context, result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  static bool pop<T extends Object>(BuildContext context, [T result]) {
    return Navigator.pop<T>(context, result);
  }

  static void popUntil(BuildContext context, String name) {
    Navigator.popUntil(context, withName(name));
  }

  static RoutePredicate withName(String name) {
    return (Route<dynamic> route) {
      List<String> routes = route.settings.name.split('/');
      List<String> myRoutes = name.split("/");
      return !route.willHandlePopInternally && route is ModalRoute && route.settings.name.startsWith(name) && routes.length == myRoutes.length;
    };
  }
}
