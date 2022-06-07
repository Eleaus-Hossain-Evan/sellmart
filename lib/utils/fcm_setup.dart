// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import '../utils/constants.dart';
// import 'local_notification.dart';

// ValueNotifier<String> deviceToken = ValueNotifier("");

// class FCMSetup with ChangeNotifier {

//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   LocalNotification _localNotification;

//   void conFigureFirebase(BuildContext context) {

//     _localNotification = LocalNotification();
//     _localNotification.initializePlugin(context);

//     _firebaseMessaging.requestNotificationPermissions(
//         IosNotificationSettings(sound: true, badge: true, alert: true)
//     );

//     _firebaseMessaging.getToken().then((token) {

//       print(token);

//       deviceToken.value = token;
//       _firebaseMessaging.subscribeToTopic(Constants.ALL_CUSTOMER);
//     });

//     try {
//       _firebaseMessaging.configure(
//         onMessage: notificationOnMessage,
//         onLaunch: notificationOnLaunch,
//         onResume: notificationOnResume,
//       );
//     } catch (error) {
//       print(error);
//     }
//   }

//   void subscribeToTopic(String topic) {

//     _firebaseMessaging.subscribeToTopic(topic);
//   }

//   Future notificationOnResume(Map<String, dynamic> message) async {

//     print(message);
//   }

//   Future notificationOnLaunch(Map<String, dynamic> message) async {

//     print(message);
//   }

//   Future notificationOnMessage(Map<String, dynamic> message) async {

//     print(message);

//     String title = message['notification']['title'];
//     String body = message['notification']['body'];

//     if(message['data']['image'] != null && message['data']['image'].toString().isNotEmpty) {

//       _localNotification.notificationWithImage(_localNotification.generalChannelID, _localNotification.generalChannelName,
//           _localNotification.generalChannelDescription, title, body, message['data']['image']);
//     }
//     else {

//       _localNotification.generalNotification(_localNotification.generalChannelID, _localNotification.generalChannelName,
//           _localNotification.generalChannelDescription, title, body);
//     }
//   }
// }