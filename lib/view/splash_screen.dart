import 'dart:async';

import 'package:flutter/services.dart';
import '../utils/version.dart';

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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin, ChangeNotifier {
  MySharedPreference _sharedPreference = MySharedPreference();

  @override
  void initState() {
    init();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUser();
    });

    super.initState();
  }

  void init() async => await checkVersion();

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

  Future<void> checkVersion() async {
    final newVersion = NewVersion(
      androidId: 'com.sellmart.app',
      // context: context,
      // dismissText: "Cancel",
      // dismissAction: () => SystemNavigator.pop(),
      // dialogText: 'Update Now',
    );

    /// only notify the users.
    // newVersion.showAlertIfNecessary(context: context);

    await newVersion.getVersionStatus().then((value) {
      if (value.localVersion != value.storeVersion) {
        print(
            'Local version: ${value.localVersion} Store version: ${value.storeVersion}');

        ///
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: value,
          dialogTitle: 'Please Update',
          dialogText:
              'Your App needs an update. you must need to update this App to use.\nCurrent version is ${value.localVersion}. Store version is ${value.storeVersion}',

          // ///
          updateButtonText: 'Update now',

          // ///
          dismissButtonText: 'Close App',
          allowDismissal: false,
          dismissAction: () => SystemNavigator.pop(),
        );
      }
    });
  }
}
