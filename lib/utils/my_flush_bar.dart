import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class MyFlushBar {

  static void show(BuildContext context, String message) {

    Flushbar(
      message: message,
      duration: Duration(milliseconds: 2500),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier),
      borderRadius: 1.25 * SizeConfig.heightSizeMultiplier,
    )..show(context);
  }
}