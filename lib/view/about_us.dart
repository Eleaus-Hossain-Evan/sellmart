import '../localization/app_localization.dart';
import '../resources/images.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'home.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  PackageInfo _packageInfo;

  String _version = "";

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 9.375 * SizeConfig.heightSizeMultiplier),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                                ),
                                Container(
                                  width: 51.28 * SizeConfig.widthSizeMultiplier,
                                  height:
                                      12.5 * SizeConfig.heightSizeMultiplier,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.appIcon),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                                ),
                                Text(
                                  _version,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                SizedBox(
                                  height: 4.5 * SizeConfig.heightSizeMultiplier,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 3.84 * SizeConfig.widthSizeMultiplier,
                                    right:
                                        3.84 * SizeConfig.widthSizeMultiplier,
                                  ),
                                  child: Material(
                                    elevation: 1,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        1.25 * SizeConfig.heightSizeMultiplier),
                                    child: Container(
                                      padding: EdgeInsets.all(1.875 *
                                          SizeConfig.heightSizeMultiplier),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            1.25 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                      ),
                                      child: Text(
                                        info.value.aboutUs ?? "",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[700],
                                              height: .175 *
                                                  SizeConfig
                                                      .heightSizeMultiplier,
                                              wordSpacing: .512 *
                                                  SizeConfig
                                                      .widthSizeMultiplier,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MyAppBar(
                    AppLocalization.of(context).getTranslatedValue("about_us"),
                    onBackPress: () {
                      _onBackPress();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPress() {
    Navigator.pop(context);
    return Future(() => false);
  }

  Future<void> _init() async {
    _packageInfo = await PackageInfo.fromPlatform();

    _version = "V " + _packageInfo.version;

    if (mounted) {
      setState(() {});
    }
  }
}
