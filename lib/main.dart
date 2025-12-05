import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/firebase_messaging.dart';
import 'package:tzens/app/controllers/messages.dart';
import 'package:tzens/app/controllers/messages.dart' as Messages;
import 'package:tzens/app/controllers/notification_history_controller.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'app/utils/screen/loading_screen.dart';
import 'app/utils/screen/splash_screen.dart';

// final navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    print("🚀 === APP INITIALIZATION ===");
    
    // ✅ Initialize Firebase PERTAMA
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("✅ Firebase initialized");

    // ✅ Registrasi background handler HANYA SEKALI
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    print("✅ Background handler registered");

    // ✅ Initialize storage
    await GetStorage.init();
    print("✅ Storage initialized");
    
    // ✅ Initialize Messages controller
    final messagesC = Get.put(Messages.Messages(), permanent: true);
    print("✅ Messages controller initialized");
    
    // ✅ Initialize notifications
    await messagesC.initNotif();
    print("✅ Notifications initialized");

    // ✅ Get stored token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("✅ FCM Token: ${prefs.getString("fcmToken")}");

    print("🏁 === APP INITIALIZATION COMPLETE ===");
    
    runApp(MyApp());
    FlutterNativeSplash.remove();
    
  } catch (e, stackTrace) {
    print("❌ Initialization error: $e");
    print("❌ Stack trace: $stackTrace");
  }
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);
  final notificationC = Get.put(NotificationHistoryController(), permanent: true);
  final contentC = Get.put(ContentController(), permanent: true);
  final messageC = Get.find<Messages.Messages>();

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: Future.delayed(Duration(seconds: 3)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ScreenUtilInit(
                      designSize: const Size(360,690),
                      minTextAdapt: true,
                      splitScreenMode: true,
                      child: GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: "Applicatmiion",
                        initialRoute: authC.isSkipIntro.isTrue
                            ? authC.isAuth.isTrue
                                ? authC.user.value.role == "provider" ||
                                        authC.user.value.role == "lecturer"
                                    ? Routes.HOME_PROVIDER
                                    : Routes.HOME
                                : Routes.LOGIN
                            : Routes.INTRODUCTION,
                        getPages: AppPages.routes,
                      ),
                    );
                  }

                  return FutureBuilder(
                    future: authC.firstInitialized(),
                    builder: (ctx, snapshot) {
                      return SplashScreen();
                    },
                  );
                });
          }

          return LoadingScreen();
        });
  }
}
