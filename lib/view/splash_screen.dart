import 'dart:async';

import '../presenter/user_presenter.dart';
import '../utils/shared_preference.dart';

import '../utils/size_config.dart';

import '../route/route_manager.dart';

import '../resources/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  MySharedPreference _sharedPreference = MySharedPreference();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _getUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {

        return Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              width: 102.5 * SizeConfig.widthSizeMultiplier,
              height: 25 * SizeConfig.heightSizeMultiplier,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.appIcon),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _getUser() async {

    currentUser.value = await _sharedPreference.getCurrentUser();
    currentUser.notifyListeners();

    Timer(Duration(milliseconds: 1500), () {
      _openHomePage();
    });
  }


  void _openHomePage() {

    Navigator.pop(context);
    Navigator.of(context).pushNamed(RouteManager.BOTTOM_NAV, arguments: 0);
  }
}