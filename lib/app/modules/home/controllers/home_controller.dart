import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tzens/app/modules/home/views/home_view.dart';
import 'package:tzens/app/modules/home/views/organisasi.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxInt currentPages = 0.obs;

  final pages = [
    WebinarView(),
    Container(
      color: Colors.amber,
    )
  ];
  void changePage(int activePageIndex) {
    currentPages.value = activePageIndex;
    update();
  }
}
