import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 加载布局基类
abstract class BaseRefreshView extends StatelessWidget {
  @protected
  int getStatus();//状态

  @protected
  Widget buildLoading(BuildContext context);

  @protected
  Widget buildEnd(BuildContext context);

  @protected
  Widget buildError(BuildContext context);

  @protected
  Widget buildReadyLoad(BuildContext context);

  @protected
  Widget buildReleaseLoad(BuildContext context);

  Widget buildCompleted(BuildContext context) {
    return new Container();
  }

  Widget _buildBody(BuildContext context) {
    if (getStatus() == RefreshStatus.noMore) {
      return buildEnd(context);
    } else if (getStatus() == RefreshStatus.failed) {
      return buildError(context);
    } else if (getStatus() == RefreshStatus.canRefresh) {
      return buildReleaseLoad(context);
    } else if (getStatus() == RefreshStatus.refreshing) {
      return buildLoading(context);
    } else if (getStatus() == RefreshStatus.idle) {
      return buildReadyLoad(context);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return getStatus() == RefreshStatus.completed
        ? buildCompleted(context)
        : Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Center(
              child: _buildBody(context),
            ),
          );
  }
}
