import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/config.dart';

// // ✅ Global instance untuk local notifications
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// // ✅ Background handler dengan debugging yang lebih lengkap
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("🚀 === BACKGROUND HANDLER STARTED ===");
//   print("📱 Message ID: ${message.messageId}");
//   print("📋 Title: ${message.notification?.title}");
//   print("📝 Body: ${message.notification?.body}");
//   print("📊 Data: ${message.data}");

//   try {
//     // ✅ Initialize Firebase
//     await Firebase.initializeApp();
//     print("✅ Firebase initialized in background");

//     // ✅ PENTING: Inisialisasi local notifications di background
//     await _initializeLocalNotificationsForBackground();
//     print("✅ Local notifications initialized");

//     // ✅ Tampilkan notifikasi dengan banner
//     await _showBackgroundNotificationWithBanner(message);
//     print("✅ Background notification processing completed");
//   } catch (e) {
//     print("❌ Error in background handler: $e");
//     print("❌ Stack trace: ${StackTrace.current}");
//   }

//   print("🏁 === BACKGROUND HANDLER FINISHED ===");
// }

// // ✅ Inisialisasi khusus untuk background dengan debugging
// Future<void> _initializeLocalNotificationsForBackground() async {
//   print("🔧 Initializing background local notifications...");

//   try {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     print("✅ FlutterLocalNotificationsPlugin initialized");

//     // ✅ KUNCI: Buat notification channel dengan importance MAX
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description:
//           'This channel is used for important notifications that need to show as banner.',
//       importance: Importance.max, // ✅ Ini yang bikin banner muncul
//       enableLights: true,
//       enableVibration: true,
//       showBadge: true,
//       playSound: true,
//     );

//     final androidPlugin =
//         flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();

//     if (androidPlugin != null) {
//       await androidPlugin.createNotificationChannel(channel);
//       print("✅ Background notification channel created successfully");
//     } else {
//       print("❌ AndroidFlutterLocalNotificationsPlugin is null");
//     }
//   } catch (e) {
//     print("❌ Error in _initializeLocalNotificationsForBackground: $e");
//   }
// }

// // ✅ Tampilkan notifikasi dengan banner di background dengan debugging
// Future<void> _showBackgroundNotificationWithBanner(
//     RemoteMessage message) async {
//   print("🔔 Showing background notification...");

//   final notification = message.notification;
//   if (notification == null) {
//     print("⚠️ No notification payload in background message");
//     return;
//   }

//   try {
//     // ✅ Configuration untuk banner notification
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       channelDescription: 'Important notifications that show as banner.',
//       importance: Importance.max, // ✅ MAX importance
//       priority: Priority.high, // ✅ High priority
//       showWhen: true,
//       enableLights: true,
//       enableVibration: true,
//       playSound: true,
//       icon: '@mipmap/ic_launcher',
//       largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//       styleInformation: BigTextStyleInformation(
//         notification.body ?? '',
//         contentTitle: notification.title ?? '',
//         summaryText: 'T-Zens',
//       ),
//       // ✅ PENTING: Ini yang bikin banner muncul
//       fullScreenIntent: false,
//       category: AndroidNotificationCategory.message,
//       visibility: NotificationVisibility.public,
//     );

//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     // ✅ Generate unique notification ID based on timestamp
//     final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     print("🆔 Generated notification ID: $notificationId");

//     await flutterLocalNotificationsPlugin.show(
//       notificationId,
//       notification.title ?? 'New Notification',
//       notification.body ?? 'You have a new message',
//       platformChannelSpecifics,
//       payload: jsonEncode(message.data),
//     );

//     print("✅ Background banner notification shown successfully");
//     print("📱 Final ID: $notificationId");
//     print("📋 Final Title: ${notification.title}");
//     print("📝 Final Body: ${notification.body}");
//   } catch (e) {
//     print("❌ Error showing background notification: $e");
//     print("❌ Stack trace: ${StackTrace.current}");
//   }
// }

// ✅ Messages class yang diperbaiki
class Messages extends GetxController {
  final RxList<RemoteMessage> notification = RxList<RemoteMessage>();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final authC = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    _initializeForegroundNotifications();
    initNotif();
    pushNotif();
  }

  // ✅ Fokus hanya pada foreground notifications
  Future<void> _initializeForegroundNotifications() async {
    try {
      // Setup foreground notification handling
      print("✅ Foreground notifications initialized");
    } catch (e) {
      print("❌ Error initializing foreground notifications: $e");
    }
  }

  void addNotif(RemoteMessage message) {
    notification.add(message);
  }

  Future<void> pushNotif() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 Foreground message received: ${message.messageId}');
      addNotif(message);
      showForegroundNotification(message);
    });
  }

  Future<void> showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    try {
      Get.snackbar(
        notification.title ?? 'New Notification',
        notification.body ?? 'You have a new message',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );

      print("✅ Foreground notification shown");
    } catch (e) {
      print("❌ Error showing foreground notification: $e");
    }
  }

  Future<void> initNotif() async {
    try {
      // ✅ Request permission
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      
      print("🔐 Notification permission: ${settings.authorizationStatus}");

      // ✅ Get token
      final String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await authC.updateToken(token);
        print("✅ FCM Token obtained and saved");
      } else {
        print("❌ FCM token is null");
      }

      // ✅ Handle app opened from notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('🔔 Message clicked: ${message.messageId}');
        // Handle navigation here
      });

      // ✅ Handle initial message
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('🔔 App opened from notification: ${initialMessage.messageId}');
        // Handle initial navigation here
      }

    } catch (e) {
      print("❌ Error in initNotif: $e");
    }
  }

   /// Fungsi untuk ambil Access Token dari service account JSON
  Future<String> _getAccessToken() async {
    // Baca JSON dari assets
    final serviceAccountJson =
        await rootBundle.loadString('assets/json/service-account.json');
    final Map<String, dynamic> credentials = json.decode(serviceAccountJson);

    final accountCredentials =
        auth.ServiceAccountCredentials.fromJson(credentials);

    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client =
        await auth.clientViaServiceAccount(accountCredentials, scopes);

    final accessToken = client.credentials.accessToken.data;

    client.close();
    return accessToken;
  }

  /// Kirim notifikasi pakai FCM HTTP v1
  Future<void> sendNotificationToAdmin(
      String token, String message, String title) async {
    try {
      final accessToken = await _getAccessToken();

      // Ganti dengan project_id dari Firebase Console
      const String projectId = Config.firebaseProjectId;
      final url = Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "token": token,
            "notification": {
              "title": title,
              "body": message,
            },
            "data": {
              "id": "1",
              "status": "done",
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully (HTTP v1)');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  // ❌ HAPUS method handleBackgroundMessage() - tidak diperlukan lagi
}
