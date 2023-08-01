import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseLocalNotificationService {
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late final AndroidNotificationChannel androidNotificationChannel;

  FirebaseLocalNotificationService() {
    androidNotificationChannel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    _configAndroid();
  }

  void _configAndroid() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel)
        .then((value) {
      _inicializedNotifications();
    });
  }

  void _inicializedNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    flutterLocalNotificationsPlugin
        .initialize(const InitializationSettings(android: android, iOS: iOS));
  }

  void androidNotification({
    required RemoteNotification remoteNotification,
    required AndroidNotification androidNotification,
  }) {
    flutterLocalNotificationsPlugin.show(
      remoteNotification.hashCode,
      remoteNotification.title,
      remoteNotification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          icon: androidNotification.smallIcon,
        ),
      ),
    );
  }
}
