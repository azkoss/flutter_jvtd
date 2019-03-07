import 'package:flutter/material.dart';

/// 空布局状态、无、加载、空、错误
enum EmptyStatus { NONE, LOADING, EMPTY, ERROR }

//空布局基类
abstract class BaseEmptyView extends StatelessWidget {
  final EmptyStatus emptyStatus;//空布局状态

  const BaseEmptyView({Key key, this.emptyStatus}) : super(key: key);

  //创建loading布局
  @protected
  Widget buildLoading(BuildContext context);

  //创建空布局
  @protected
  Widget buildEmpty(BuildContext context);

  //创建error布局
  @protected
  Widget buildError(BuildContext context);

  //布局控制
  Widget _buildView(BuildContext context) {
    if (emptyStatus == EmptyStatus.EMPTY) {
      return buildEmpty(context);
    } else if (emptyStatus == EmptyStatus.ERROR) {
      return buildError(context);
    } else if (emptyStatus == EmptyStatus.LOADING) {
      return buildLoading(context);
    }
    return Center();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
