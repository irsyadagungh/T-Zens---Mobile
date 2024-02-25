import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/model/introduction_model.dart';
import 'package:tzens/app/utils/widget/introduction_widget.dart';

import '../controllers/introduction_controller.dart';
import '../../../utils/constant/introduction_utils.dart';

class IntroductionView extends GetView<IntroductionController> {
  final pages = [
    Introduction(
      model: IntroductionModel(
          bgColor: onBoardingColor1,
          lottie: lottieOnBoarding1,
          title: title1,
          subtitle: subtitle,
          button: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Swipe"), Icon(Icons.arrow_forward)],
          )),
    ),
    Introduction(
      model: IntroductionModel(
          bgColor: onBoardingColor2,
          lottie: lottieOnBoarding2,
          title: title2,
          subtitle: subtitle2,
          button: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Swipe"), Icon(Icons.arrow_forward)],
          )),
    ),
    Introduction(
      model: IntroductionModel(
          bgColor: onBoardingColor3,
          lottie: lottieOnBoarding3,
          title: title3,
          subtitle: subtitle3,
          button: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Continue"))
            ],
          )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [LiquidSwipe(pages: pages)],
    ));
  }
}
