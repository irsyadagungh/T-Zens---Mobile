

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/notification_history_controller.dart';

class HomeProviderController extends GetxController {
  final contentC = Get.find<ContentController>();
  final notificationController = Get.find<NotificationHistoryController>();
  final auth = Get.find<AuthController>();



  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  RxBool isScrolling = true.obs;
  RxString idContent = "".obs;

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    contentC.readDataOrganization();
    contentC.readDataProvider();
    notificationController.fetchNotificationHistory(auth.user.value.uid!);
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
