import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';

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
  print(Firebase.apps.length > 0);
  print("DARI MAIN");
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);
  final contentC = Get.put(ContentController(), permanent: true);

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
                    return DynamicColorBuilder(builder:
                        (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                      return GetMaterialApp(
                        theme: ThemeData(
                            useMaterial3: true, colorScheme: lightDynamic),
                        darkTheme: ThemeData(
                          useMaterial3: true,
                          colorScheme: darkDynamic,
                        ),
                        debugShowCheckedModeBanner: false,
                        title: "Application",
                        initialRoute: authC.isSkipIntro.value == true
                            ? Routes.WELCOME
                            : Routes.LOGIN,
                        getPages: AppPages.routes,
                      );
                    });
                  }

                  return SplashScreen();
                });
          }

          return LoadingScreen();
        });
  }
}
