import 'dart:ui';
import 'package:flutter/material.dart';
import '../localization/app_localization.dart';

import 'size_config.dart';

class MyOverlayLoader {

  OverlayEntry loader;
  bool _isLoading = false;

  void customLoaderWithBlurEffect(BuildContext context) {

    _isLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {

        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.3, sigmaY: 2.3),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                  child: Container(
                    height: 10 * SizeConfig.heightSizeMultiplier,
                    padding: EdgeInsets.only(
                      top: 3.125 * SizeConfig.heightSizeMultiplier,
                      bottom: 3.125 * SizeConfig.heightSizeMultiplier,
                      left: 8.97 * SizeConfig.widthSizeMultiplier,
                      right: 8.97 * SizeConfig.widthSizeMultiplier,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Text(AppLocalization.of(context).getTranslatedValue("please_wait"),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(width: 5.12 * SizeConfig.widthSizeMultiplier,),

                        Container(
                          height: 3.125 * SizeConfig.heightSizeMultiplier,
                          width: 6.41 * SizeConfig.widthSizeMultiplier,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: .769 * SizeConfig.widthSizeMultiplier,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  void customLoader(BuildContext context) {

    _isLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {

        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: .769 * SizeConfig.widthSizeMultiplier,
              ),
            ),
          ),
        );
      },
    );
  }


  void dismissDialog(BuildContext context) {

    if(_isLoading) {

      _isLoading = false;
      Navigator.of(context).pop();
    }
  }
}