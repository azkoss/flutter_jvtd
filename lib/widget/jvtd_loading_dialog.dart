import 'package:flutter/material.dart';
import 'package:flutter_jvtd_dialog/flutter_jvtd_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JvtdLoadingDialog extends BaseDialog {
  JvtdLoadingDialog({Key key}) : super(key: key);

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: getWidthFactor(), height: getWidthFactor()),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SpinKitCircle(
        color: Colors.white,
        size: 64,
      ),
    );
  }

  @override
  double getWidthFactor() {
    return 96;
  }

  @override
  bool getCancelOutside() => false;

  @override
  bool getKeyBackEnabled() => false;
}
