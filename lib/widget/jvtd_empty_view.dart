import 'package:flutter/material.dart';
import '../base/base_empty_view.dart';
import 'jvtd_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JvtdEmptyView extends BaseEmptyView {
  final EmptyStatus emptyStatus; //空布局当前状态
  final String iconName; //图标
  final String emptyImgName; //空图片
  final String emptyText; //空一级提示
  final TextStyle emptyTextStyle; //空提示文字样式
  final String emptyTips; //空二级提示 可选
  final TextStyle emptyTipsTextStyle; //空二级提示样式
  final Widget emptyButton; //空布局按钮 可选
  final String errorText; //错误提示
  final TextStyle errorTextStyle; //错误提示样式 无则与空提示相同
  final String loadingText; //加载提示文字
  final TextStyle loadingTextStyle; //加载提示文字样式 无则与空提示相同
  final Color loadingColor; //颜色
  final Widget loadingWidget; //加载样式  无则默认
  final bool isList; //是否是列表
  final GestureTapCallback onErrorPressed; //错误按键方法

  JvtdEmptyView({
    @required this.emptyStatus,
    @required this.iconName,
    @required this.emptyImgName,
    this.emptyText = '暂无此类数据',
    this.emptyTextStyle = const TextStyle(color: Colors.black87, fontSize: 14),
    this.emptyTips,
    this.emptyTipsTextStyle = const TextStyle(color: Colors.black54, fontSize: 12),
    this.emptyButton,
    this.errorText = '加载失败，点击重试',
    this.errorTextStyle,
    this.loadingText,
    this.loadingTextStyle,
    this.loadingColor = Colors.grey,
    this.loadingWidget,
    this.onErrorPressed,
    this.isList = false,
  });

  List<Widget> _buildEmptyView(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(JvtdImage.local(name: emptyImgName));
    widgets.add(Text(
      emptyText,
      style: emptyTextStyle,
    ));
    if (emptyTips != null) {
      widgets.add(Text(
        emptyTips,
        style: emptyTipsTextStyle,
      ));
    }
    if (emptyButton != null) {
      widgets.add(emptyButton);
    }
    return widgets;
  }

  @override
  Widget buildEmpty(BuildContext context) {
    return Center(
      heightFactor: isList ? 2 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildEmptyView(context),
      ),
    );
  }

  @override
  Widget buildError(BuildContext context) {
    return Center(
      heightFactor: isList ? 5 : 1,
      child: GestureDetector(
        onTap: onErrorPressed,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            errorText,
            style: errorTextStyle == null ? emptyTextStyle : errorTextStyle,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLoadingView(BuildContext context) {
    List<Widget> widgets = List();
    if (loadingWidget == null) {
      widgets.add(SpinKitCircle(
        color: loadingColor,
        size: 72,
      ));
    } else {
      widgets.add(loadingWidget);
    }
    if (loadingText != null) {
      widgets.add(Text(
        loadingText,
        style: loadingTextStyle == null ? emptyTextStyle : loadingTextStyle,
      ));
    }
    return widgets;
  }

  @override
  Widget buildLoading(BuildContext context) {
    return Center(
      heightFactor: isList ? 4 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildLoadingView(context),
      ),
    );
  }
}
