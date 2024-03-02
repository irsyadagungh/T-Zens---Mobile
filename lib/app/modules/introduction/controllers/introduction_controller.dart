import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:tzens/app/modules/welcome/views/welcome_view.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/constant/introduction_utils.dart';
import 'package:tzens/app/utils/model/introduction_model.dart';
import 'package:tzens/app/utils/widget/introduction_widget.dart';

class IntroductionController extends GetxController {
  //TODO: Implement IntroductionController

  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    Introduction(
      model: IntroductionModel(
          bgColor: onBoardingColor1,
          lottie: lottieOnBoarding1,
          title: title1,
          subtitle: subtitle,
          button: Text("")),
    ),
    Introduction(
      model: IntroductionModel(
          bgColor: onBoardingColor2,
          lottie: lottieOnBoarding2,
          title: title2,
          subtitle: subtitle2,
          button: Text("")),
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
              ElevatedButton(
                  onPressed: () {
                    // Action when button pressed
                    Get.to(() => WelcomeView());
                  },
                  child: Text('Continue'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(164, 50)),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => primaryColor),
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ))
            ],
          )),
    ),
  ];

  void onPagedIndexChanged(int activePageIndex) =>
      currentPage.value = activePageIndex;
}
