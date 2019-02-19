import 'package:flutter/material.dart';

enum DialogStyle {
  NORMAL, //居中
  BOTTOM, //中下
  TOP, //中上
}

///自定义dialog显示，添加背景颜色设置
Future<T> showJvtdDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black12,
  Duration transitionDuration = const Duration(milliseconds: 150),
  bool isSafe = true,
  @required WidgetBuilder builder,
}) {
  assert(debugCheckHasMaterialLocalizations(context));
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
      final Widget pageChild = Builder(builder: builder);
      return isSafe
          ? SafeArea(
              child: Builder(builder: (BuildContext context) {
                return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
              }),
            )
          : Builder(builder: (BuildContext context) {
              return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
            });
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

//基础dialog类
abstract class BaseDialog extends Dialog {
  double getWidthFactor() => 0.8; //宽度比例
  bool getCancelOutside() => true; //点击外部是否可关闭
  bool getKeyBackEnabled() => true; //返回键是否可关闭
  MaterialType getMaterialType() => MaterialType.transparency; //dialog效果
  DialogStyle getDialogStyle() => DialogStyle.NORMAL; //居中

  @override
  Widget build(BuildContext context) {
    return Material(
      type: getMaterialType(),
      child: WillPopScope(
        child: Stack(
          alignment: _alignment(), //布局的展示位置
          children: <Widget>[
            GestureDetector(
              onTap: () {
                //实现点击外部布局关闭当前界面
                if (getCancelOutside()) {
                  close(context);
                }
              },
            ),
            //根据宽度的属性进行不同布局创建、大于1则按固定尺寸创建，小于等于1则按屏幕宽度百分比创建
            getWidthFactor() > 1
                ? SizedBox(
                    width: getWidthFactor(),
                    child: buildBody(context),
                  )
                : FractionallySizedBox(
                    widthFactor: getWidthFactor(),
                    child: buildBody(context),
                  ),
          ],
        ),
        onWillPop: _keyBackPop, //拦截返回键时间进行自定义操作
      ),
    );
  }

  //布局展示位置判断
  Alignment _alignment() {
    switch (getDialogStyle()) {
      case DialogStyle.NORMAL:
        return Alignment.center;
      case DialogStyle.BOTTOM:
        return Alignment.bottomCenter;
      case DialogStyle.TOP:
        return Alignment.topCenter;
    }
    return Alignment.center;
  }

  //创建子布局
  @protected
  Widget buildBody(BuildContext context);

  //返回键拦截监听
  Future<bool> _keyBackPop() {
    return new Future.value(getKeyBackEnabled());
  }

  //关闭当前dialog
  void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  BaseDialog({Key key}) : super(key: key);
}
