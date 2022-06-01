import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class BottomAlignedButton extends StatelessWidget {

  final String buttonText;
  final Color color;
  final void Function() onPressed;

  BottomAlignedButton(this.buttonText, {this.color = Colors.orange, this.onPressed});

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {

          FocusScope.of(context).unfocus();
          this.onPressed();
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 1.5 * SizeConfig.heightSizeMultiplier,
            left: 3.84 * SizeConfig.widthSizeMultiplier,
            right: 3.84 * SizeConfig.widthSizeMultiplier,
          ),
          child: Container(
            height: 5 * SizeConfig.heightSizeMultiplier,
            decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier,),
            ),
            child: Center(
              child: Text(this.buttonText,
                style: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}