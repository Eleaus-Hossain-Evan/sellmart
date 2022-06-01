import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../localization/app_localization.dart';
import '../utils/custom_log.dart';
import '../utils/custom_trace.dart';
import '../utils/size_config.dart';
import '../view/home.dart';
import 'package:flutter/material.dart';

import 'my_button.dart';

class UpdateDialog extends StatefulWidget {

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {

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
        child: Padding(
          padding: EdgeInsets.only(
            top: 3.75 * SizeConfig.heightSizeMultiplier,
            left: 5.12 * SizeConfig.widthSizeMultiplier,
            right: 5.12 * SizeConfig.widthSizeMultiplier,
            bottom: 3.75 * SizeConfig.heightSizeMultiplier,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: .769 * SizeConfig.widthSizeMultiplier),
                child: Text(AppLocalization.of(context).getTranslatedValue("app_update"),
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

              Padding(
                padding: EdgeInsets.only(left: .769 * SizeConfig.widthSizeMultiplier),
                child: Text((Platform.isAndroid && info.value.androidUpdateMandatory) ||
                    (Platform.isIOS && info.value.iosUpdateMandatory) ?
                AppLocalization.of(context).getTranslatedValue("mandatory_update_msg") :
                AppLocalization.of(context).getTranslatedValue("optional_update_msg"),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black.withOpacity(.75),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 5 * SizeConfig.heightSizeMultiplier,),

              MyButton(AppLocalization.of(context).getTranslatedValue("update"),
                marginLeft: 4.5,
                marginRight: 4.5,
                onPressed: () {

                  _launchURL(Platform.isAndroid ? info.value.playStoreUrl : info.value.appStoreUrl);
                },
              ),

              Visibility(
                visible: (Platform.isAndroid && !info.value.androidUpdateMandatory) || (Platform.isIOS && !info.value.iosUpdateMandatory),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {

                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 2.5 * SizeConfig.heightSizeMultiplier,
                    ),
                    child: Text(AppLocalization.of(context).getTranslatedValue("not_now"),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {

    if(await canLaunch(url)) {

      CustomLogger.debug(trace: CustomTrace(StackTrace.current), tag: "Launching URL", message: url);
      await launch(url);
    }
    else {

      CustomLogger.error(trace: CustomTrace(StackTrace.current), tag: "Failed To Launch URL", message: url);
      throw 'Could not launch $url';
    }
  }
}