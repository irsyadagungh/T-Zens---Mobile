import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tzens/app/controllers/auth_controller.dart';

import 'package:http/http.dart' as http;
import 'package:tzens/config.dart';

class Messages extends GetxController {
  final RxList<RemoteMessage> notification = RxList<RemoteMessage>();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final authC = Get.put(AuthController);

  void addNotif(RemoteMessage message) {
    notification.add(message);
  }

  Future<void> pushNotif() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      addNotif(message);
    });
  }

  Future<void> sendNotificationToAdmin(String token, String title, String body) async {
  final url = 'https://fcm.googleapis.com/fcm/send';
  final serverKey = Config.firebaseApiKey; // Replace with your Firebase server key

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final notification = {
    'to': token,
    'notification': {
      'title': title,
      'body': body,
    },
  };

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(notification),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}

  Future<void> initNotif(SharedPreferences prefs) async {
    await FirebaseMessaging.instance.requestPermission();
    final String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      prefs.setString("fcmToken", token);
      print("FCM Token: $token");
    } else {
      print("FCM token is null");
    }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    print("Handling a background message: ${message.data}");
    final notification = message.notification;
    if (notification != null) {
      print("Title Message: ${notification.title}");
      print("Body Message: ${notification.body}");
    } else {
      print("Notification data is null");
    }
  }
}
