import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

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

const String PARAMS_KEY = 'JVTDPARAMS';

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
  static Handler params({@required HandlerFunc handlerFunc}) {
    return Handler(handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
      String paramsStr = parameters[PARAMS_KEY]?.first;
      Map<String, List<String>> decodeParameters = {};
      if(paramsStr != null && paramsStr.isNotEmpty){
        var list = List<int>();
        ///字符串解码
        jsonDecode(paramsStr).forEach(list.add);
        final String value = Utf8Decoder().convert(list);
        decodeParameters = json.decode(value);
      }
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
String mapToRouteParams(Map<String, String> map) {
  String jsonString = json.encode(map);
  var jsons = jsonEncode(Utf8Encoder().convert(jsonString));
  return "?"+PARAMS_KEY+"=$jsons";
}
