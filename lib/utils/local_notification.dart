import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

//add permissions in manifest
//add the receiver in manifest
//add necessary code in AppDelegate.swift/AppDelete.m

class LocalNotification {

  BuildContext context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  PackageInfo packageInfo;

  String orderChannelID;
  String campaignChannelID;
  String generalChannelID;
  String accountChannelID;

  String orderChannelName = "Order";
  String campaignChannelName = "Payment";
  String generalChannelName = "General";
  String accountChannelName = "Account";

  String orderChannelDescription = "Order related notifications";
  String campaignChannelDescription = "Different campaign and offer notifications";
  String generalChannelDescription = "General notifications";
  String accountChannelDescription = "Account related notifications";

  Future initializePlugin(BuildContext context) async {

    this.context = context;
    packageInfo = await PackageInfo.fromPlatform();

    orderChannelID = packageInfo.packageName + "order";
    campaignChannelID = packageInfo.packageName + "campaign";
    generalChannelID = packageInfo.packageName + "general";
    accountChannelID = packageInfo.packageName + "account";

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = AndroidInitializationSettings('logo');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: didReceiveLocalNotification,
    );

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }


  Future selectNotification(String payload) async {

    showDialog(
      context: context,
      builder: (_) {

        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }


  Future<void> didReceiveLocalNotification(int id, String title, String body, String payload) async {

    // iOS does not support notification when app is in foreground
    // so show the notification contents as an dialog

    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(

        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }


  Future<void> generalNotification(String channelID, String channelName, String channelDescription, String title, String body) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        channelID, channelName, channelDescription,
        importance: Importance.Max,
        enableVibration: true,
        enableLights: true,
        visibility: NotificationVisibility.Public,
        ledColor: Colors.blue,
        ledOnMs: 1000,
        ledOffMs: 500,
        //sound: RawResourceAndroidNotificationSound('notification_sound'),
        playSound: true,
        priority: Priority.High,
    );

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show((Random().nextInt(300) + Random().nextInt(150) - Random().nextInt(180)) * Random().nextInt(5), title, body, platformChannelSpecifics);
  }


  Future<void> notificationWithImage(String channelID, String channelName, String channelDescription, String title, String body, String imageURL) async {

    if(imageURL != null) {

      final String bigPicturePath = await _downloadAndSaveFile(imageURL, "notification_image");

      BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));

      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        channelID, channelName, channelDescription,
        importance: Importance.Max,
        enableVibration: true,
        enableLights: true,
        visibility: NotificationVisibility.Public,
        ledColor: Colors.blue,
        ledOnMs: 1000,
        ledOffMs: 500,
        //sound: RawResourceAndroidNotificationSound('notification_sound'),
        playSound: true,
        priority: Priority.High,
        styleInformation: bigPictureStyleInformation,
      );

      var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
        attachments: <IOSNotificationAttachment>[
          IOSNotificationAttachment(bigPicturePath)
        ],
      );

      var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show((Random().nextInt(300) + Random().nextInt(150) - Random().nextInt(180)) * Random().nextInt(5), title, body, platformChannelSpecifics);
    }
  }


  Future<String> _downloadAndSaveFile(String url, String fileName) async {

    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }


  Future<void> generalNotificationWithoutSoundAndVibration(String channelID, String channelName, String channelDescription, String title, String body) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        channelID, channelName, channelDescription,
        importance: Importance.Max,
        enableLights: true,
        enableVibration: false,
        visibility: NotificationVisibility.Public,
        ledColor: Colors.blue,
        ledOnMs: 1000,
        ledOffMs: 500,
        playSound: false,
        priority: Priority.High);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show((Random().nextInt(300) + Random().nextInt(150) - Random().nextInt(180)) * Random().nextInt(5), title, body, platformChannelSpecifics);
  }


  Future<List<PendingNotificationRequest>> getPendingNotificationList() async {

    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }


  Future<void> cancelNotification(int id) async {

    await flutterLocalNotificationsPlugin.cancel(id);
  }


  Future<void> cancelAllNotification() async {

    await flutterLocalNotificationsPlugin.cancelAll();
  }


  Future<bool> wasAppLaunched() async {

    var notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails.didNotificationLaunchApp;
  }
}