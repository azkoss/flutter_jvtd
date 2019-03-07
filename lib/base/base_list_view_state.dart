import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_empty_view.dart';
import 'base_refresh_view.dart';

/// listviewstate基类
///
/// 主要控制下拉刷新、上拉加载、布局展示及空布局异常布局
abstract class BaseListViewState<M, T extends StatefulWidget> extends State<T> {
  bool isOpenEmpty = true; //是否开启空布局
  bool isEmptyAndHeaderFooter = true; //空布局是否与守卫布局共存
  bool isFirst = true; //是否显示首次loading
  bool isRefresh = true; //是否有下拉刷新
  bool isLoadMore = true; //是否有上拉加载

  bool autoRefresh = true; //第一次自动加载

  bool oldLoadMoreStatus; //老状态

  EmptyStatus _emptyStatus;

  EmptyStatus get emptyStatus => _emptyStatus; //空布局状态

  List<M> listData = <M>[]; //基础数据

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    oldLoadMoreStatus = isLoadMore;
    isLoadMore = false;
    _refreshController = new RefreshController();
    if (autoRefresh) {
      onRefresh();
    }
    firstState();
  }

  //首次空布局状态
  void firstState() {
    _emptyStatus = !isFirst ? EmptyStatus.NONE : EmptyStatus.LOADING;
  }

  //头布局
  @protected
  List<Widget> headerWidgets();

  //尾布局
  @protected
  List<Widget> footerWidgets();

  //加载更多布局
  @protected
  BaseRefreshView buildLoadMoreView(BuildContext context, int loadMoreStatus);

  //刷新布局
  @protected
  BaseRefreshView buildRefreshView(BuildContext context, int refreshStatus);

  @protected
  Config headerConfig();

  @protected
  Config footerConfig();

  //初始化空布局
  @protected
  BaseEmptyView buildEmptyView();

  //初始化全局空布局
  Widget _buildScrollEmptyView() {
    return CustomScrollView(
      slivers: <Widget>[
        buildEmptyView(),
      ],
    );
  }

  //获取头布局个数
  int _getHeaderCount() {
    return headerWidgets() == null ? 0 : headerWidgets().length;
  }

  //获取尾布局个数
  int _getFooterCount() {
    return footerWidgets() == null ? 0 : footerWidgets().length;
  }

  //是否显示空布局
  bool _isShowEmpty() {
    return listData.length == 0 && isOpenEmpty;
  }

  //list标准个数
  int _getListCount() {
    return _isShowEmpty() ? 1 : listData.length;
  }

  //总个数
  int _getAllListCount() {
    if (_isShowEmpty() && !isEmptyAndHeaderFooter) return 1;
    return _getListCount() + _getHeaderCount() + _getFooterCount();
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return _buildWidget(context, position);
      },
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: _getAllListCount(),
    );
  }

  Widget _buildWidget(BuildContext context, int position) {
    if (position < _getHeaderCount()) {
      //头布局
      return headerWidgets().elementAt(position);
    } else if (position >= _getHeaderCount() + _getListCount()) {
      //尾布局
      return footerWidgets().elementAt(position - (_getHeaderCount() + _getListCount()));
    } else {
      if (_isShowEmpty()) {
        return buildEmptyView();
      } else {
        return buildItemWidget(context, position - _getHeaderCount());
      }
    }
  }

  @protected
  Widget buildItemWidget(BuildContext context, int position);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: isRefresh,
        enablePullUp: isLoadMore,
        headerBuilder: (context, mode) {
          return buildRefreshView(context, mode);
        },
        headerConfig: headerConfig(),
        footerBuilder: (context, mode) {
          return buildLoadMoreView(context, mode);
        },
        footerConfig: footerConfig(),
        child: _isShowEmpty() && !isEmptyAndHeaderFooter ? _buildScrollEmptyView() : _buildList(context),
        onRefresh: _onRefresh,
      ),
    );
  }

  void _onRefresh(bool up) {
    if (up) {
      onRefresh();
    } else {
      loadMore();
    }
  }

  @protected
  Future onRefresh();

  @protected
  Future loadMore();

  //重新请求
  void toRefresh() {
    setState(() {
      isFirst = true;
      firstState();
    });
  }

  void refreshError() {
    setState(() {
      loadData(loadData: []);
      _emptyStatus = EmptyStatus.ERROR;
      isLoadMore = false;
    });
  }

  void loadMoreError() {
    _refreshController.sendBack(false, RefreshStatus.failed);
  }

  void loadData({bool refresh = true, List<M> loadData}) {
    setState(() {
      if (refresh) {
        listData.clear();
        listData.addAll(loadData);
        if (listData.length <= 0) {
          _emptyStatus = EmptyStatus.EMPTY;
          isLoadMore = false;
        } else {
          isLoadMore = oldLoadMoreStatus;
        }
        _refreshFinish();
        _refreshController.sendBack(false, RefreshStatus.idle);
      } else {
        listData.addAll(loadData);
        _loadMoreFinish(
          end: loadData.length <= 0,
        );
      }
    });
  }

  void _refreshFinish() {
    _refreshController.sendBack(
      true,
      RefreshStatus.completed,
    );
  }

  void _loadMoreFinish({bool end = false}) {
    _refreshController.sendBack(
      false,
      end ? RefreshStatus.noMore : RefreshStatus.completed,
    );
  }
}
