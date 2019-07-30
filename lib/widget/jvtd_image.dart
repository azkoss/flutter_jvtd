import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:transparent_image/transparent_image.dart';

class JvtdImage {
  //全局配置图片本地路径
  static String localImagePath = "assets/images/";

  //全局配置图片网络路径
  static String networkImagePath = "";

  //获取本地图片路径
  /// name 图片名
  static String imagePath({@required String name}) {
    return localImagePath + name;
  }

  //获取本地图片资源
  /// name 图片名
  static AssetImage assetImage({@required String name}) {
    return AssetImage(imagePath(name: name));
  }

  //加载本地图片
  /// name 图片名
  /// width 宽
  /// height 高
  /// color 颜色
  /// colorBlendMode 颜色混合模式
  /// fit 显示模式
  /// alignment 显示位置
  /// repeat 图片重复
  /// matchTextDirection 遵循文本方向
  static Image local(
      {@required String name,
      double width,
      double height,
      Color color,
      BlendMode colorBlendMode,
      BoxFit fit = BoxFit.cover,
      AlignmentGeometry alignment = Alignment.center,
      ImageRepeat repeat = ImageRepeat.noRepeat,
      bool matchTextDirection = false}) {
    return Image.asset(imagePath(name: name),
        width: width, height: height, color: color, colorBlendMode: colorBlendMode, fit: fit, alignment: alignment, repeat: repeat, matchTextDirection: matchTextDirection);
  }

  //加载网络图片
  /// name 图片名
  /// placeholderImgName 占位图片名
  /// errorImgName 错误图片名
  /// placeholder 占位图空间
  /// errorWidget 错误图空间
  /// width 宽
  /// height 高
  /// color 颜色
  /// colorBlendMode 颜色混合模式
  /// fit 显示模式
  /// alignment 显示位置
  /// repeat 图片重复
  /// matchTextDirection 遵循文本方向
  /// httpHeaders 网络头信息
  static CachedNetworkImage network(
      {@required String url,
      String placeholderImgName,
      String errorImgName,
      Widget placeholder,
      Widget errorWidget,
      double width,
      double height,
      BoxFit fit = BoxFit.cover,
      AlignmentGeometry alignment = Alignment.center,
      ImageRepeat repeat = ImageRepeat.noRepeat,
      bool matchTextDirection = false,
      Map<String, String> httpHeaders}) {
    //加载中占位图
    if (url == null) {
      url = '';
    }
    if (!url.startsWith('http')) {
      url = networkImagePath + url;
    }
    if (placeholder == null && placeholderImgName != null) {
      placeholder = local(name: placeholderImgName);
    }
    //加载失败图片
    if (errorWidget == null && errorImgName != null) {
      errorWidget = local(name: errorImgName);
    } else {
      errorWidget = placeholder;
    }
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: placeholder,
      errorWidget: errorWidget,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      httpHeaders: httpHeaders,
    );
  }
}
