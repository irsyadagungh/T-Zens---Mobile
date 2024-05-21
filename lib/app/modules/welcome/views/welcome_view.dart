import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/login/views/login_view.dart';
import 'package:tzens/app/modules/register/views/register_view.dart';
import 'package:tzens/app/utils/widget/large_button.dart';
import 'package:tzens/app/utils/widget/large_outlined_button.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    print(auth.isSkipIntro.value);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lottie Animation
          Container(
            child: Lottie.asset('assets/lottie/login.json'),
          ),

          // Text
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("to T-Zens"),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Finding for seminars or organizations with just one click without needing to provide any personal information.",
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),

          // Buttons
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text("Choose your role")),
                  LargeButton(
                    text: "Student",
                    onPressed: () {
                      auth.role.value = "student";
                      Get.to(() => RegisterView());
                    },
                  ),
                  LargeOutlinedButton(
                    onPressed: () {
                      auth.role.value = "provider";
                      Get.to(() => RegisterView());
                    },
                    text: "Provider",
                  )
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          // Already have an account
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.to(() => LoginView());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
