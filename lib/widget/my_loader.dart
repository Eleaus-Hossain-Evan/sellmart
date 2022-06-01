import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class MyLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: .769 * SizeConfig.widthSizeMultiplier,
        ),
      ),
    );
  }
}