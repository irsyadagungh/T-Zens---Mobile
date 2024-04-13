import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tzens/app/modules/home/views/home_view.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/screen/organisasi_Screen.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

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
