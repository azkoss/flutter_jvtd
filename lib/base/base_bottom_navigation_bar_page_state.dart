import 'package:flutter/material.dart';
import 'base_page_state.dart';
import '../redux/jvtd_state.dart';
import '../widget/jvtd_image.dart';

/// 底部导航页面基类
abstract class BaseBottomNavigationBarPageState<T extends StatefulWidget, S extends JvtdState> extends BasePageState<T, S> {
  bool get isAppBar => false;//是否显示appbar

  PageController pageController; //page左右切换界面
  int pageIndex = 0; //当前页面下标

  double fontSize = 10; //字体大小
  double iconSize = 29; //图片大小

  bool isAnimate = false; //是否添加动画
  bool isScroll = false; //是否启用手势滚动
  BottomNavigationBarType type = BottomNavigationBarType.fixed; //底部导航显示样式

  @protected
  Color selectedColor();//选中颜色

  @protected
  Color unSelectedColor();//未选中颜色

  //界面数组 必须重写
  @protected
  List<Widget> pages();

  //底部item数组 必须重写
  @protected
  List<BottomNavigationBarItem> barItems(BuildContext context);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.pageIndex);
  }

  //初始化baritem方法
  /// icon 选中图标
  /// title 标题
  BottomNavigationBarItem barItem({IconData icon, String title}) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: unSelectedColor()), //未选中图标
      activeIcon: Icon(icon, color: selectedColor()), //选中图标
      title: new Text(
        title,
        style: TextStyle(fontSize: fontSize, color: type == BottomNavigationBarType.shifting ? selectedColor() : null),
      ),
    );
  }

  //初始化baritem方法
  /// selectImg 选中图片
  /// unSelectImg 未选中图片
  /// title 标题
  BottomNavigationBarItem imageBarItem({
    String selectImg,
    String unSelectImg,
    String title,
  }) {
    return BottomNavigationBarItem(
      icon: JvtdImage.local(name: unSelectImg, width: iconSize, height: iconSize, fit: BoxFit.contain), //未选中图标
      activeIcon: JvtdImage.local(name: selectImg, width: iconSize, height: iconSize, fit: BoxFit.contain), //选中图标
      title: new Text(
        title,
        style: TextStyle(fontSize: fontSize, color: type == BottomNavigationBarType.shifting ? selectedColor() : null),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return PageView(
      children: pages(), //添加页面参数
      controller: pageController, //页面控制器
      onPageChanged: onPageChanged, //切换方法
      physics: isScroll ? null : NeverScrollableScrollPhysics(), //禁止滑动
    );
  }

  @override
  Widget buildNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: barItems(context),
      //触控参数
      onTap: onTap,
      //点击事件
      type: type,
      fixedColor: selectedColor(),
      currentIndex: pageIndex,
    );
  }

  void onTap(int index) {
    if (isAnimate) {
      //动画跳转
      pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    } else {
      //无动画跳转
      pageController.jumpToPage(index);
    }
  }

  void onPageChanged(int page) {
    setState(() {
      this.pageIndex = page;
    });
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }
}
