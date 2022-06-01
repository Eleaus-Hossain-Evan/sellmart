import '../widget/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../view/home.dart';

class UpdateCheck {

  static Future<void> checkForUpdate(BuildContext context) async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    try {

      if(info != null && info.value.appVersionName != null && info.value.appVersionName.isNotEmpty) {

        String serverVersion = info.value.appVersionName.replaceAll(".", "");
        String appVersion = packageInfo.version.replaceAll(".", "");

        if(int.parse(serverVersion) > int.parse(appVersion)) {

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {

                return UpdateDialog();
              }
          );
        }
      }
    }
    catch(error) {

      print(error);
    }
  }
}