import 'package:flutter/material.dart';
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
    return Container(
      // bg Color
      color: model.bgColor,

      // Content
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip Button
              Column(
                children: [
                  Align(alignment: Alignment.centerRight, child: Text("Skip")),

                  SizedBox(
                    height: 100,
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
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      )),

                  // Subtitle
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          model.subtitle,
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              ),

              // Swipe
              model.button
            ],
          ),
        ),
      ),
    );
  }
}
