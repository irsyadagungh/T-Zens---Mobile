import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/messages.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/utils/screen/loading_screen.dart';
import 'app/utils/screen/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Messages messages = Messages();
  await messages.initNotif(prefs);
  await GetStorage.init();
  print("FCM Token: ${prefs.getString("fcmToken")}");
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);
  final contentC = Get.put(ContentController(), permanent: true);
  final messageC = Get.put(Messages(), permanent: true);

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
                    return DynamicColorBuilder(builder:
                        (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                      print("ROLE: ${authC.user.value.role}");
                      return GetMaterialApp(
                        theme: ThemeData(
                            useMaterial3: true, colorScheme: lightDynamic),
                        darkTheme: ThemeData(
                          useMaterial3: true,
                          colorScheme: darkDynamic,
                        ),
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
                      );
                    });
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
