import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final String title, message;
  final void Function() onNegativeButtonPress, onPositiveButtonPress;

  CustomDialog({this.title = "", this.message = "", this.onNegativeButtonPress, this.onPositiveButtonPress});

  @override
  Widget build(BuildContext context) {

    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.5 * SizeConfig.heightSizeMultiplier),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Container(
            padding: EdgeInsets.all(2.5 * SizeConfig.heightSizeMultiplier),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
                topLeft: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
              ),
            ),
            child: Column(
              children: <Widget>[

                Center(
                  child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                Center(
                  child: Text(message,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(
              top: 1.875 * SizeConfig.heightSizeMultiplier,
              bottom: 1.875 * SizeConfig.heightSizeMultiplier,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
                bottomRight: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
              ),
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

                      Navigator.of(context).pop();
                      this.onNegativeButtonPress();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        CircleAvatar(
                          radius: 1.875 * SizeConfig.heightSizeMultiplier,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.close, color: Colors.white, size: 5.12 * SizeConfig.imageSizeMultiplier,),
                        ),

                        SizedBox(height: 1.25 * SizeConfig.widthSizeMultiplier,),

                        Text(AppLocalization.of(context).getTranslatedValue("no"),
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 2.5 * SizeConfig.heightSizeMultiplier,),

                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                      Navigator.of(context).pop();
                      this.onPositiveButtonPress();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        CircleAvatar(
                          radius: 1.875 * SizeConfig.heightSizeMultiplier,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.check, color: Colors.white, size: 5.12 * SizeConfig.imageSizeMultiplier,),
                        ),

                        SizedBox(height: 1.25 * SizeConfig.widthSizeMultiplier,),

                        Text(AppLocalization.of(context).getTranslatedValue("yes"),
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}