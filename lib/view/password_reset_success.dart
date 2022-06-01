import '../widget/my_button.dart';

import '../localization/app_localization.dart';
import '../resources/images.dart';
import '../route/route_manager.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class PasswordResetSuccessfulPage extends StatefulWidget {

  @override
  _PasswordResetSuccessfulPageState createState() => _PasswordResetSuccessfulPageState();
}

class _PasswordResetSuccessfulPageState extends State<PasswordResetSuccessfulPage> {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {

        return Future(() => false);
      },
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: ScrollConfiguration(
                behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 13 * SizeConfig.heightSizeMultiplier,
                            bottom: 3.75 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: SizedBox(
                            width: 30 * SizeConfig.widthSizeMultiplier,
                            height: 14.5 * SizeConfig.heightSizeMultiplier,
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(Images.verify,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5 * SizeConfig.heightSizeMultiplier,
                            bottom: 3.75 * SizeConfig.heightSizeMultiplier,
                            left: 3 * SizeConfig.widthSizeMultiplier,
                            right: 3 * SizeConfig.widthSizeMultiplier,
                          ),
                          child: Text(AppLocalization.of(context).getTranslatedValue("your_password_is_successfully_reset"),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5 * SizeConfig.heightSizeMultiplier,),

                      MyButton(AppLocalization.of(context).getTranslatedValue("continue").toUpperCase(),
                        marginLeft: 3.84,
                        marginRight: 3.84,
                        onPressed: () {

                          _openLoginPage();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  void _openLoginPage() {

    Navigator.pop(context);
    Navigator.of(context).pushNamed(RouteManager.LOGIN);
  }
}