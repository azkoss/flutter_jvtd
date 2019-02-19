import 'package:flutter/material.dart';
import '../base/base_dialog.dart';
import 'package:flutter/services.dart';

typedef OnJvtdAlertClickCallBack = void Function(AlertDialogBtn position, String text); //触控回调
typedef OnJvtdAlertEmptyCallBack = void Function(String msg); //输入为空的回调

//按钮位置 左中右
enum AlertDialogBtn {
  LEFT,
  RIGHT,
  CENTER,
}

class JvtdAlertDialog extends BaseDialog {
  final String title; //标题 默认提示
  final TextStyle titleStyle; //标题style 默认黑色，16号
  final String leftBtnText; //左侧按钮文本 默认取消
  final String rightBtnText; //右侧按钮文本 默认确定
  final String centerBtnText; //中间按钮文本 默认无
  final TextStyle btnStyle; //按钮style 默认黑色 16号
  final List<AlertDialogBtn> showBtns; //显示按钮 默认 左右显示
  final Color lineColor; //线颜色 默认 e8e8e8颜色

  //普通模式内容
  final String message; //内容
  final TextStyle messageStyle; //内容样式 默认666颜色

  //录入模式
  final bool isInput; //是否为输入
  final int maxLength; //最大输入字数 默认8个字
  final String editHint; //提示文字
  final TextStyle hintStyle; //内容样式 默认999颜色
  final String editText; //输入的默认文字
  final TextStyle textStyle; //内容样式 默认666颜色
  final String editEmptyText; //空输入后的返回文字
  final bool isShowEmptyText; //是否显示空文字如果未输入文字的情况下
  final String toastText; //输入为空后的吐司文字
  final TextInputType keyboardType; //键盘输入类型

  final OnJvtdAlertClickCallBack onClick; //触控回调
  final OnJvtdAlertEmptyCallBack onTips; //输入为空的提示

  //其他配置
  final bool cancelOutside; //点击外部是否可关闭
  final bool keyBackEnabled; //返回键是否可关闭
  final Color bgColor; //背景颜色

  String _inputText; //录入文字
  JvtdAlertDialog({
    Key key,
    this.title = '提示',
    this.titleStyle = const TextStyle(color: Color(0xff000000), fontSize: 16, fontWeight: FontWeight.bold),
    this.leftBtnText = '取消',
    this.rightBtnText = '确定',
    this.centerBtnText,
    this.btnStyle = const TextStyle(color: Color(0xff000000), fontSize: 16, fontWeight: FontWeight.bold),
    this.showBtns = const <AlertDialogBtn>[AlertDialogBtn.LEFT, AlertDialogBtn.RIGHT],
    this.message,
    this.messageStyle = const TextStyle(color: Color(0xff666666), fontSize: 14),
    this.isInput = false,
    this.maxLength = TextField.noMaxLength,
    this.editHint = '请输入内容',
    this.editText,
    this.editEmptyText,
    this.isShowEmptyText = false,
    this.lineColor = const Color(0xffe8e8e8),
    this.hintStyle = const TextStyle(color: Color(0xff999999), fontSize: 14),
    this.textStyle = const TextStyle(color: Color(0xff666666), fontSize: 14),
    this.toastText = '输入内容不能为空',
    this.keyboardType = TextInputType.text,
    this.cancelOutside = true,
    this.keyBackEnabled = true,
    this.bgColor = const Color(0xffffffff),
    this.onTips,
    @required this.onClick,
  })  : _inputText = editText != null ? editText : '',
        super(key: key);

  @override
  bool getCancelOutside() {
    return cancelOutside;
  }

  @override
  bool getKeyBackEnabled() {
    return keyBackEnabled;
  }

  @override
  double getWidthFactor() {
    return 0.8;
  }

  @override
  Widget buildBody(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        color: bgColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildAlert(context),
        ),
      ),
    );
  }

  List<Widget> _buildAlert(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 24),
      child: Column(
        children: _buildTitleAndInfo(context),
      ),
    ));
    widgets.add(Divider(
      height: 1,
      color: lineColor,
    ));

    widgets.add(_buildButton(context));

    return widgets;
  }

  List<Widget> _buildTitleAndInfo(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: lineColor,
          width: 0.5,
        ));
    List<Widget> widgets = [];
    widgets.add(Text(
      title,
      style: titleStyle,
      textAlign: TextAlign.center,
      maxLines: 1,
    ));
    TextEditingController controller = TextEditingController.fromValue(
      TextEditingValue(
        text: _inputText,
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: _inputText.length),
        ),
      ),
    );
    widgets.add(Container(
      margin: EdgeInsets.only(left: isInput ? 0 : 16, right: isInput ? 0 : 16, top: 24),
      child: IndexedStack(
        alignment: Alignment.topCenter,
        index: isInput ? 1 : 0,
        children: <Widget>[
          Text(
            message == null ? '' : message,
            style: messageStyle,
            textAlign: TextAlign.center,
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              border: inputBorder,
              focusedBorder: inputBorder,
              disabledBorder: inputBorder,
              enabledBorder: inputBorder,
              errorBorder: inputBorder,
              focusedErrorBorder: inputBorder,
              fillColor: Color(0xfffafafa),
              hasFloatingPlaceholder: false,
              hintStyle: hintStyle,
              hintText: editHint,
              counter: Container(),
              //此属性可去除计数器
              hintMaxLines: 1,
              labelStyle: textStyle,
              labelText: isShowEmptyText && editText == null ? editEmptyText : editText,
            ),
            autofocus: isInput,
            controller: controller,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            cursorColor: Theme.of(context).primaryColor,
            maxLength: maxLength,
            keyboardType: keyboardType,
            maxLines: 1,
            onChanged: (input) {
              _inputText = input;
            },
            onEditingComplete: () {},
          )
        ],
      ),
    ));
    return widgets;
  }

  Widget _buildButton(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < showBtns.length; i++) {
      AlertDialogBtn btn = showBtns[i];
      widgets.add(
        Expanded(
          child: RawMaterialButton(
            child: Text(
              _getBtnText(btn, context),
              style: btnStyle,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            constraints: BoxConstraints.expand(height: 44),
            onPressed: () {
              _clickBtn(btn, context);
            },
            shape: btn != AlertDialogBtn.RIGHT ? Border(right: BorderSide(color: lineColor, width: 0.5)) : RoundedRectangleBorder(),
          ),
        ),
      );
    }
    return Row(
      children: widgets,
    );
  }

  String _getBtnText(AlertDialogBtn btn, BuildContext context) {
    if (btn == AlertDialogBtn.LEFT) {
      return leftBtnText;
    } else if (btn == AlertDialogBtn.RIGHT) {
      return rightBtnText;
    }
    return centerBtnText;
  }

  void _clickBtn(AlertDialogBtn btn, BuildContext context) {
    bool closeDialog = true;
    if (btn == AlertDialogBtn.RIGHT && isInput && _inputText.isEmpty && editEmptyText == null) {
      if (onTips != null) {
        onTips(toastText);
      }
      closeDialog = false;
    }
    if (closeDialog) {
      close(context);
      this.onClick(btn, _inputText);
    }
  }
}
