import 'package:flutter/material.dart';

///垂直按钮 继承FlatButton，标准模式下与FlatButton完全一致
///icon创建 space 按钮中间间隙
class VerticalButton extends FlatButton {
  const VerticalButton({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    @required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          child: child,
        );

  factory VerticalButton.icon({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior,
    MaterialTapTargetSize materialTapTargetSize,
    double space,
    @required Widget icon,
    @required Widget label,
  }) = _VerticalButtonWith;
}

class _VerticalButtonWith extends VerticalButton with MaterialButtonWithIconMixin {
  _VerticalButtonWith({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior,
    MaterialTapTargetSize materialTapTargetSize,
    @required Widget icon,
    @required Widget label,
    double space = 0,
  })  : assert(icon != null),
        assert(label != null),
        super(
          key: key,
          onPressed: onPressed,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              SizedBox(height: space),
              label,
            ],
          ),
        );
}

//按钮组排列方式
enum ButtonGroupOrientation {
  ROW,
  COLUMN,
}

//按钮组
class ButtonGroup extends StatelessWidget {
  final List<Widget> buttons; //按钮控件
  final ButtonGroupOrientation orientation; //排列方式

  const ButtonGroup({
    Key key,
    @required this.buttons,
    this.orientation = ButtonGroupOrientation.ROW,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orientation == ButtonGroupOrientation.ROW ? _buildRow(context) : _buildColumn(context);
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      children: _buildExpanded(context),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      children: _buildExpanded(context),
    );
  }

  List<Widget> _buildExpanded(BuildContext context) {
    return buttons.map((button) {
      return Expanded(child: button);
    }).toList();
  }
}
