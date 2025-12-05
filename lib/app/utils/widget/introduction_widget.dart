import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tzens/app/modules/welcome/views/welcome_view.dart';
import '../model/introduction_model.dart';
import 'package:lottie/lottie.dart';

class Introduction extends StatelessWidget {
  const Introduction({
    Key? key,
    required this.model,
  }) : super(key: key);

  final IntroductionModel model;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // bg Color
        color: model.bgColor,

        // Content
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Skip Button
                Column(
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Get.to(() => WelcomeView());
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(color: Colors.black),
                            ))),

                    SizedBox(
                      height: 100.h,
                    ),

                    // Lottie
                    Lottie.asset(model.lottie),

                    // Title
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            model.title,
                            style: TextStyle(
                                fontSize: 28.sp.clamp(20, 30),
                                fontWeight: FontWeight.bold),
                          ),
                        )),

                    // Subtitle
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            model.subtitle,
                            style: TextStyle(fontSize: 16.sp.clamp(12, 20)),
                          ),
                        )),
                  ],
                ),

                SizedBox(
                  height: 100.h,
                ),

                // Swipe
                model.button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
