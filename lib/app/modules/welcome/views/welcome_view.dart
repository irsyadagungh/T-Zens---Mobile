import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/login/views/login_view.dart';
import 'package:tzens/app/modules/register/views/register_view.dart';
import 'package:tzens/app/utils/constant/color.dart';
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
        body: SingleChildScrollView(
          child: LayoutBuilder(builder: (ctx, constraints) {
            return OrientationBuilder(builder: (ctx, orientation) {
              bool isWide = constraints.maxWidth > 1050.w;
              bool isLandscape = orientation == Orientation.landscape;
              print("isWide: $isWide");

              return isWide || isLandscape
                  ? Row(
                      children: buildChildren(context, true, auth),
                    )
                  : Column(
                      children: buildChildren(context, false, auth),
                    );
            });
          }),
        ));
  }
}

List<Widget> buildChildren(
    BuildContext context, bool isWideScreen, AuthController auth) {
  return [
    // Lottie Animation
    Expanded(
      flex: isWideScreen ? 1 : 0,
      child: Container(
        child: Lottie.asset('assets/lottie/login.json'),
      ),
    ),

    // Text
    Expanded(
      flex: isWideScreen ? 1 : 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30.sp.clamp(28, 35),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("to T-Zens"),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Finding for seminars or organizations with just one click without needing to provide any personal information.",
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 50.h,
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
                    color:
                        WidgetStateColor.resolveWith((states) => primaryColor),
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
            height: 20.h,
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
          ),
        ],
      ),
    )
  ];
}
