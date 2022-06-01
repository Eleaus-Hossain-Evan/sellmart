import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'my_button.dart';

class MyErrorWidget extends StatefulWidget {

  final String subTitle;
  final void Function() onPressed;

  MyErrorWidget({this.subTitle, this.onPressed});

  @override
  _MyErrorWidgetState createState() => _MyErrorWidgetState();
}

class _MyErrorWidgetState extends State<MyErrorWidget> {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Dialog(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.25 * SizeConfig.heightSizeMultiplier),
        ),
        child: Container(
          padding: EdgeInsets.all(3.75 * SizeConfig.heightSizeMultiplier),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.25 * SizeConfig.heightSizeMultiplier),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              CircleAvatar(
                radius: 3.75 * SizeConfig.heightSizeMultiplier,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.close, size: 10.25 * SizeConfig.imageSizeMultiplier, color: Colors.white,),
              ),

              SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

              Center(
                child: Text(AppLocalization.of(context).getTranslatedValue("oops"),
                  style: Theme.of(context).textTheme.headline3.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 7.69 * SizeConfig.widthSizeMultiplier,
                    right: 7.69 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Text(widget.subTitle ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 2 * SizeConfig.heightSizeMultiplier,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

              Center(
                child: MyButton(AppLocalization.of(context).getTranslatedValue("try_again").toUpperCase(),
                  onPressed: () {

                    widget.onPressed();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}