import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/utils/screen/loading_screen.dart';
import 'app/utils/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: Future.delayed(Duration(seconds: 3)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: "Application",
                      initialRoute: authC.isSkipIntro.isTrue
                          ? Routes.HOME
                          : Routes.INTRODUCTION,
                      getPages: AppPages.routes,
                    );
                  }

                  return SplashScreen();
                });
          }

          return LoadingScreen();
        });
  }
}
