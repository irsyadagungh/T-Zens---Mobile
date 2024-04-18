import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tzens/app/controllers/auth_controller.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    Get.put(IntroductionController());
    final controller = Get.find<IntroductionController>();
    final auth = Get.find<AuthController>();
    print(auth.isSkipIntro.value);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        LiquidSwipe(
          onPageChangeCallback: controller.onPagedIndexChanged,
          pages: controller.pages,
          liquidController: controller.controller,
          enableSideReveal: true,
          slideIconWidget: Obx(() {
            print(controller.currentPage.value);
            return controller.currentPage.value == 2
                ? Text("")
                : GestureDetector(
                    onTap: () {
                      int next = controller.currentPage.value + 1;
                      controller.controller.animateToPage(page: next);
                    },
                    child: Icon(Icons.arrow_back_ios));
          }),
          waveType: WaveType.liquidReveal,
          enableLoop: false,
        ),
        Obx(
          () => Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: controller.currentPage.value,
              count: 3,
              effect: WormEffect(activeDotColor: Colors.black, dotHeight: 5.0),
            ),
          ),
        )
      ],
    ));
  }
}
