import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';

class HomeProviderController extends GetxController {
  final contentC = Get.find<ContentController>();

  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  RxBool isScrolling = true.obs;

  RxInt selectedIndex = 0.obs;

  final pages = [
    GridView.builder(
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200),
      itemBuilder: (context, index) {
        return Container(
          color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
        );
      },
    ),
    Container(color: Colors.green),
    Container(color: Colors.blue),
  ];

  @override
  void onInit() {
    super.onInit();
    contentC.readData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index.obs.value;
    update(); // Memicu pembaruan tampilan widget
  }
}
