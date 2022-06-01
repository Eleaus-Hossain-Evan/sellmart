import '../resources/images.dart';
import '../widget/my_app_bar.dart';

import '../localization/app_localization.dart';
import '../localization/localization_constrants.dart';
import '../utils/shared_preference.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LanguagePage extends StatefulWidget {

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  MySharedPreference _preference = MySharedPreference();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("language"),
                    onBackPress: _onBackPress,
                  ),

                  SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

                  Padding(
                    padding: EdgeInsets.only(
                      left: 5 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Text(AppLocalization.of(context).getTranslatedValue("select_preferred_language"),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black.withOpacity(.75),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 5 * SizeConfig.heightSizeMultiplier,),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: <Widget>[

                          _divider(),

                          ListTile(
                            onTap: () {

                              _onOptionSelected(BANGLA);
                            },
                            dense: true,
                            leading: Image.asset(Images.bdFlag,
                              height: 5 * SizeConfig.heightSizeMultiplier,
                              width: 10.25 * SizeConfig.widthSizeMultiplier,
                              fit: BoxFit.fill,
                            ),
                            title: Text(AppLocalization.of(context).getTranslatedValue("bangla"),
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: BANGLA,
                                groupValue: MyApp.appLocale.languageCode,
                                activeColor: Theme.of(context).primaryColor,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity(vertical: 0),
                                onChanged: _onOptionSelected,
                              ),
                            ),
                          ),

                          _divider(),

                          ListTile(
                            onTap: () {

                              _onOptionSelected(ENGLISH);
                            },
                            dense: true,
                            leading: Image.asset(Images.usaFlag,
                              height: 4.5 * SizeConfig.heightSizeMultiplier,
                              width: 9 * SizeConfig.widthSizeMultiplier,
                              fit: BoxFit.fill,
                            ),
                            title: Text(AppLocalization.of(context).getTranslatedValue("english"),
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: ENGLISH,
                                groupValue: MyApp.appLocale.languageCode,
                                activeColor: Theme.of(context).primaryColor,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity(vertical: 0),
                                onChanged: _onOptionSelected,
                              ),
                            ),
                          ),

                          _divider(),
                        ],
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


  Widget _divider() {

    return Container(
      color: Theme.of(context).hintColor,
      height: .5 * SizeConfig.heightSizeMultiplier,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: .625 * SizeConfig.heightSizeMultiplier,
        bottom: .625 * SizeConfig.heightSizeMultiplier,
      ),
    );
  }


  Future<void> _onOptionSelected(String languageCode) async {

    Locale locale = await _preference.saveLanguageCode(languageCode);

    MyApp.setLocale(context, locale);
  }


  Future<bool> _onBackPress() {

    Navigator.pop(context);
    return Future(() => false);
  }
}