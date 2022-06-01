import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String buttonText;
  final double marginLeft, marginRight;
  final void Function() onPressed;

  MyButton(this.buttonText, {this.marginLeft = 0.0, this.marginRight = 0.0, this.onPressed});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {

        this.onPressed();
      },
      child: Container(
        height: 5.375 * SizeConfig.heightSizeMultiplier,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: marginLeft * SizeConfig.widthSizeMultiplier,
          right: marginRight * SizeConfig.widthSizeMultiplier,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
        ),
        child: Text(buttonText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}