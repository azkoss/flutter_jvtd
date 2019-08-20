import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../utils/encode_decode_util.dart';

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

/// 路由处理类 简化处理方式
class RouterHandler {
  //标准无参数路由处理
  static Handler standard({@required Widget page}) {
    return Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return page;
    });
  }

  /// 有参数路由处理（返回相关信息-自处理）
  ///
  /// decode 默认进行加密处理中文无法传输问题
  static Handler params({@required HandlerFunc handlerFunc,bool decode = true}) {
    if(!decode) return Handler(handlerFunc: handlerFunc);
    return Handler(handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
      Map<String, List<String>> decodeParameters = {};
      parameters.forEach((key,value){
        decodeParameters[key] = value.map((item){
          return jvtdUtf8Decode(item);
        }).toList();
      });
      return handlerFunc(context,decodeParameters);
    });
  }
}

/// 配置路由方法
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

/// 路由动画
class JvtdTransitionType {
  static TransitionType inFromRight = Platform.isIOS ? TransitionType.native : TransitionType.inFromRight;
}

/// 路由配置未实现类
abstract class JvtdRoutes {
  //获取路由配置
  @protected
  List<RouterDefine> obtainRoutes();
}

/// 字典转路由参数
///
/// encode 默认加密处理中文传输问题
String mapToRouteParams(Map<String, String> map,{bool encode = true}) {
  String paramsStr = '';
  for (int i = 0; i < map.length; i++) {
    if (i == 0) {
      paramsStr += '?';
    } else {
      paramsStr += "&";
    }
    paramsStr = paramsStr + map.keys.elementAt(i) + '=' + jvtdUtf8Encode(map.values.elementAt(i));
  }
  return paramsStr;
}
