// ===== 1. BUAT FILE TERPISAH: lib/firebase_messaging_handler.dart =====

import 'dart:convert';
import 'dart:developer' as developer; // ✅ Gunakan ini untuk background logs
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_time_patterns.dart';

// ✅ Global instance - HANYA SATU
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// ✅ Background handler yang BERSIH
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ✅ Gunakan developer.log untuk background isolate
  developer.log("🚀 === BACKGROUND HANDLER STARTED ===", name: 'FCM_BG');
  developer.log("📱 Message ID: ${message.messageId}", name: 'FCM_BG');
  developer.log("📋 Title: ${message.notification?.title}", name: 'FCM_BG');
  developer.log("📝 Body: ${message.notification?.body}", name: 'FCM_BG');
  developer.log("📊 Data: ${message.data}", name: 'FCM_BG');

  try {
    // ✅ Initialize Firebase hanya jika belum
    await Firebase.initializeApp();
    developer.log("✅ Firebase initialized in background", name: 'FCM_BG');

    // ✅ Setup notifications
    await _setupBackgroundNotifications();
    developer.log("✅ Background notifications setup complete", name: 'FCM_BG');

    // ✅ Show notification
    await _showBackgroundNotification(message);
    developer.log("✅ Background notification shown", name: 'FCM_BG');
  } catch (e, stackTrace) {
    developer.log("❌ Background handler error: $e", name: 'FCM_BG');
    developer.log("❌ Stack trace: $stackTrace", name: 'FCM_BG');
  }

  developer.log("🏁 === BACKGROUND HANDLER FINISHED ===", name: 'FCM_BG');
}

// ✅ Setup background notifications
Future<void> _setupBackgroundNotifications() async {
  developer.log("🔧 Setting up background notifications...", name: 'FCM_BG');

  try {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    bool? initialized =
        await _flutterLocalNotificationsPlugin.initialize(settings);
    developer.log("✅ Plugin initialized: $initialized", name: 'FCM_BG');

    // ✅ Create high importance channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'background_channel',
      'Background Notifications',
      description: 'High importance background notifications',
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
      showBadge: true,
      playSound: true,
    );

    final androidPlugin =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(channel);
      developer.log("✅ Background channel created", name: 'FCM_BG');
    } else {
      developer.log("❌ Android plugin is null", name: 'FCM_BG');
    }
  } catch (e) {
    developer.log("❌ Setup error: $e", name: 'FCM_BG');
  }
}

// ✅ Show background notification
Future<void> _showBackgroundNotification(RemoteMessage message) async {
  developer.log("🔔 Showing background notification...", name: 'FCM_BG');

  final notification = message.notification;
  if (notification == null) {
    developer.log("⚠️ No notification payload", name: 'FCM_BG');
    return;
  }

  try {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'background_channel',
      'Background Notifications',
      channelDescription: 'High importance background notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      icon: '@mipmap/ic_launcher',
      category: AndroidNotificationCategory.message,
      visibility: NotificationVisibility.public,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      notification.title ?? 'New Notification',
      notification.body ?? 'You have a new message',
      details,
      payload: jsonEncode(message.data),
    );

    developer.log("✅ Notification shown with ID: $notificationId",
        name: 'FCM_BG');
  } catch (e) {
    developer.log("❌ Show notification error: $e", name: 'FCM_BG');
    dateTimePatternMap();
  }
}
