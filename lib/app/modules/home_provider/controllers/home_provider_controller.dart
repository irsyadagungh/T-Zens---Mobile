import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tzens/app/controllers/content_controller.dart';

class HomeProviderController extends GetxController {
  final contentC = Get.find<ContentController>();

  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  RxBool isScrolling = true.obs;
  RxString idContent = "".obs;

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
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
