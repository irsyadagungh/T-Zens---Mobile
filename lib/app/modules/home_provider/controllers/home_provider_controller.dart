import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tzens/app/modules/home/controllers/home_controller.dart';

class HomeProviderController extends GetxController {
  late final PageController pageController;
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
    pageController = PageController();
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
