import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:io';

//路由定义类（简化定义方式）
class RouterDefine {
  String routeName; //路由名
  Handler handler; //路由处理
  TransitionType transitionType; //动画

  RouterDefine({
    @required this.routeName,
    @required this.handler,
    this.transitionType,
  });
}

typedef OnParamsCallBack = void Function(BuildContext context, Map<String, List<String>> params);

//路由处理类 简化处理方式
class RouterHandler {
  //标准无参数路由处理
  static Handler standard({@required Widget page}) {
    return Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return page;
    });
  }

  //有参数路由处理（返回相关信息-自处理）
  static Handler params({@required HandlerFunc handlerFunc}) {
    return Handler(handlerFunc: handlerFunc);
  }
}

//配置路由
void configureRoutes(Router router, JvtdRoutes routes) {
  router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print("没有找到当前路由信息！");
  });
  routes.obtainRoutes().forEach((routerDefine) {
    router.define(
      routerDefine.routeName,
      handler: routerDefine.handler,
      transitionType: routerDefine.transitionType,
    );
  });
}

class JvtdTransitionType {
  static TransitionType inFromRight = Platform.isIOS ? TransitionType.native : TransitionType.inFromRight;
}

abstract class JvtdRoutes {
  //获取路由配置
  @protected
  List<RouterDefine> obtainRoutes();
}
