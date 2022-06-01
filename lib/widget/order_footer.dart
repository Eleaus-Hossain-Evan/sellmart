import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderFooter extends StatefulWidget {

  final int index;
  final void Function() onBackPress, onNextPress;

  OrderFooter(this.index, {this.onBackPress, this.onNextPress});

  @override
  _OrderFooterState createState() => _OrderFooterState();
}

class _OrderFooterState extends State<OrderFooter> {

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: 1.875 * SizeConfig.heightSizeMultiplier,
          right: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  FocusScope.of(context).unfocus();
                  widget.onBackPress();
                },
                child: Container(
                  height: 5 * SizeConfig.heightSizeMultiplier,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier,),
                    border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                  ),
                  child: Center(
                    child: Text(AppLocalization.of(context).getTranslatedValue("back"),
                      style: Theme.of(context).textTheme.button.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 1.875 * SizeConfig.heightSizeMultiplier,),

            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  FocusScope.of(context).unfocus();
                  widget.onNextPress();
                },
                child: Container(
                  height: 5 * SizeConfig.heightSizeMultiplier,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier,),
                  ),
                  child: Center(
                    child: Text(widget.index == 1 ? AppLocalization.of(context).getTranslatedValue("confirm") : AppLocalization.of(context).getTranslatedValue("next"),
                      style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}