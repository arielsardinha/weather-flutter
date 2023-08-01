import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:open_weather_map/data/utils/firebase_messaging/firebase_local_notification.dart';





sealed class FirebaseMessagingService {
  static final FirebaseLocalNotificationService
      _firebaseLocalNotificationProvider = FirebaseLocalNotificationService();

  static void _handleAppMessage(message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _firebaseLocalNotificationProvider.androidNotification(
        remoteNotification: notification,
        androidNotification: android,
      );
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _firebaseLocalNotificationProvider.androidNotification(
        remoteNotification: notification,
        androidNotification: android,
      );
    }
  }

  static Future<void> inicialize() async {
    await FirebaseMessaging.instance.requestPermission();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(badge: true, sound: true);

    FirebaseMessaging.onMessage.listen(_handleAppMessage);

    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      log(e.toString(), name: 'Error onBackgroundMessage');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data);
    });
  }

  static Future<void> getTokenFirebase() async {
    final token = await FirebaseMessaging.instance.getToken();
    log(token ?? '', name: 'Token PushNotification');
  }
}
