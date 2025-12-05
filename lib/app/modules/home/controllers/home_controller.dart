import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/notification_history_controller.dart';
import 'package:tzens/app/utils/screen/organisasi_Screen.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';

class HomeController extends GetxController {
  final contentC = Get.find<ContentController>();
  final notificationC = Get.find<NotificationHistoryController>();
  final auth = Get.find<AuthController>();

  PageController pageController = PageController();
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    contentC.readDataUser();
    notificationC.fetchNotificationHistory(auth.user.value.uid!);
  }

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
