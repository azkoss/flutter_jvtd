import 'package:flutter/material.dart';

/// 头部导航
class JvtdAppBar extends AppBar {
  //标准白底黑字文本AppBar
  static AppBar text({
    String title,
    Widget bottom,
    Widget leading,
    List<Widget> actions,
    Color backgroundColor = Colors.white,
    TextTheme textTheme = const TextTheme(title: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
    IconThemeData iconTheme = const IconThemeData(color: Colors.black),
    bool centerTitle = true,
    double elevation = .5,
    double titleSpacing = NavigationToolbar.kMiddleSpacing,
    bool automaticallyImplyLeading = true,
    Widget flexibleSpace,
    Brightness brightness,
    bool primary = true,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
  }) {
    return standard(
      leading: leading,
      title: Text(title),
      bottom: bottom,
      actions: actions,
      backgroundColor: backgroundColor,
      textTheme: textTheme,
      iconTheme: iconTheme,
      centerTitle: centerTitle,
      elevation: elevation,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      brightness: brightness,
      primary: primary,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
    );
  }

  //标准AppBar 白底黑字
  static AppBar standard({
    Widget title,
    Widget leading,
    Widget bottom,
    List<Widget> actions,
    Color backgroundColor = Colors.white,
    TextTheme textTheme = const TextTheme(title: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
    IconThemeData iconTheme = const IconThemeData(color: Colors.black),
    bool centerTitle = true,
    double elevation = .5,
    double titleSpacing = NavigationToolbar.kMiddleSpacing,
    bool automaticallyImplyLeading = true,
    Widget flexibleSpace,
    Brightness brightness,
    bool primary = true,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
  }) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      brightness: brightness,
      primary: primary,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      leading: leading,
      title: title,
      bottom: bottom,
      actions: actions,
      backgroundColor: backgroundColor,
      textTheme: textTheme,
      iconTheme: iconTheme,
      centerTitle: centerTitle,
      elevation: elevation,
      titleSpacing: titleSpacing,
    );
  }
}
