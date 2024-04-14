import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/utils/screen/organisasi_Screen.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';

class HomeController extends GetxController {

  RxInt currentPages = 0.obs;
  final pages = [
    WebinarView(),
    OrganisasiView(),
  ];
  void changePage(int activePageIndex) {
    currentPages.value = activePageIndex;
    update();
  }
}
