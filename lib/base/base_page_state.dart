import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jvtd/flutter_jvtd.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';
import '../redux/jvtd_state.dart';
import 'package:redux/redux.dart';
import '../widget/jvtd_toast.dart';
import '../widget/jvtd_loading_dialog.dart';
import '../base/base_empty_view.dart';
import '../widget/jvtd_app_bar.dart';

/// 状态管理基础page
abstract class BasePageState<T extends StatefulWidget, S extends JvtdState> extends State<T> with AutomaticKeepAliveClientMixin<T>, RouteAware {
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  );
  Brightness appBarBrightness = Brightness.light;
  bool statusBarTranslucent = false; //是否浸入式
  bool isAppBar = true; //是否显示appbar
  Color bgColor = Colors.white; //背景颜色
  Color appBarColor = Colors.white; //appbar背景颜色
  TextStyle appBarTextStyle = TextStyle(color: Colors.black, fontSize: 18); //appbar字体样式
  JvtdLoadingDialog _loadingDialog;
  int loadingTime = 20; //loading等待时间

  Color loadingBgColor = Colors.black12; //loading整体背景颜色

  bool isDoubleClick = false; //是否双击返回桌面
  DateTime _clickTime; //返回键点击时间

  bool pageObserver = false; //监听界面跳转逻辑
  bool _isPageObserver = false;//是否已监听

  bool _isInit = false;

  bool isShowEmpty = false;
  EmptyStatus emptyStatus = EmptyStatus.LOADING;

  Store<S> mStore;

  //保存状态 用于pageview等保存状态使用
  @override
  bool get wantKeepAlive => false;

  void showLoading() {
    if (_loadingDialog == null) {
      showJvtdDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: loadingBgColor,
          builder: (context) {
            _loadingDialog = JvtdLoadingDialog();
            return _loadingDialog;
          });
      Timer(Duration(seconds: loadingTime), () {
        hideLoading();
      });
    }
  }

  void hideLoading() {
    if (_loadingDialog != null) {
      _loadingDialog.close(context);
      _loadingDialog = null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (pageObserver) {
      if(_isPageObserver) return;
      _isPageObserver = true;
      Application.routeObserver.subscribe(this, ModalRoute.of(context));
    }
    if (!_isInit) {
      _isInit = true;
      initData(context);
    }
  }

  @override
  void dispose() {
    if (pageObserver) {
      Application.routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  //初始化数据
  void initData(BuildContext context) {
    print(appBarTitle(context) + "初始化");
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    FlutterStatusbarManager.setTranslucent(statusBarTranslucent);
  }

  @protected
  Widget buildBody(BuildContext context);

  Widget buildNavigationBar(BuildContext context) {
    return Container(width: 0, height: 0);
  }

  //appbar 标题
  String appBarTitle(BuildContext context) {
    return "";
  }

  //标准appbar 可重写自定义 标题为空则不显示
  Widget appBar(BuildContext context) {
    if (appBarTitle(context) == null || appBarTitle(context).isEmpty || !isAppBar) return null;
    return JvtdAppBar.text(
      title: appBarTitle(context),
      backgroundColor: appBarColor,
      textTheme: TextTheme(title: appBarTextStyle),
      iconTheme: IconThemeData(color: appBarTextStyle.color),
      brightness: appBarBrightness,
      actions: buildActions(context),
    );
  }

  //创建actions
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  Widget _buildBase(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: isShowEmpty
          ? Center(
              child: buildEmptyView(context),
            )
          : buildBody(context),
      bottomNavigationBar: buildNavigationBar(context),
      backgroundColor: bgColor,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  //创建悬浮按钮
  Widget buildFloatingActionButton(BuildContext context) {
    return Container(width: 0, height: 0);
  }

  //创建空布局
  @protected
  Widget buildEmptyView(BuildContext context);

  //空布局异常处理
  void emptyErrorPressed() {
    setState(() {
      emptyStatus = EmptyStatus.LOADING;
    });
  }

  //隐藏空布局
  void hideEmptyView() {
    setState(() {
      isShowEmpty = false;
    });
  }

  //显示空布局异常样式
  void showEmptyErrorView() {
    setState(() {
      emptyStatus = EmptyStatus.ERROR;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<S>(builder: (context, store) {
      mStore = store;
      return Localizations.override(
        context: context,
        locale: store.state.locale,
        child: isDoubleClick
            ? WillPopScope(
                child: _buildBase(context),
                onWillPop: _onWillPop,
              )
            : _buildBase(context),
      );
    });
  }

  Future<bool> _onWillPop() {
    if (_clickTime != null && DateTime.now().difference(_clickTime) < Duration(seconds: 2)) {
      return Future.value(true);
    } else {
      _clickTime = DateTime.now();
      JvtdToast.showMessage(msg: exitAppTips(), context: context);
      return Future.value(false);
    }
  }

  //双击退出APP提示文字
  String exitAppTips() {
    return '';
  }

  //关闭键盘
  void closeKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void setState(fn) {
    if (!mounted) return;
    super.setState(fn);
  }
}
