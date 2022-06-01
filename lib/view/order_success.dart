import 'package:flutter/material.dart';
import '../localization/app_localization.dart';
import '../resources/images.dart';
import '../route/route_manager.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';

import 'home.dart';

class OrderSuccess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {

        _onBackPress(context);
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Column(
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("order_placed"),
                    onBackPress: () {

                      _onBackPress(context);
                    },
                  ),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 12.5 * SizeConfig.heightSizeMultiplier,),

                            Image.asset(Images.accept,
                              height: 10 * SizeConfig.heightSizeMultiplier,
                              width: 20.51 * SizeConfig.widthSizeMultiplier,
                              fit: BoxFit.fill,
                            ),

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            Text(AppLocalization.of(context).getTranslatedValue("thank_you").toUpperCase(),
                              style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 5 * SizeConfig.textSizeMultiplier,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),

                            SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                            Text(AppLocalization.of(context).getTranslatedValue("order_is_places"),
                              style: Theme.of(context).textTheme.headline5.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 23.07 * SizeConfig.widthSizeMultiplier,
                                right: 23.07 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: Column(
                                children: <Widget>[

                                  Text(AppLocalization.of(context).getTranslatedValue("order_placed_msg"),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                                  Text(info.value.phone ?? "",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),

                                  Text(info.value.email ?? "",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  void _onBackPress(BuildContext context) {

    Navigator.of(context).pushNamed(RouteManager.BOTTOM_NAV, arguments: 0);
  }
}