import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/screen/organisasi_Screen.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';
import 'package:tzens/app/utils/widget/nav_bar.dart';
import 'package:tzens/app/utils/widget/top_app_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    if (controller.auth == null || controller.auth.user == null) {
      // Handle the case where auth or auth.user is null
      return CircularProgressIndicator(); // or any other placeholder widget
    }

    return Scaffold(
      backgroundColor: customWhite,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          controller.onInit();
        },
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            TopAppBar(
              auth: controller.auth,
              notificationController: controller.notificationC,
              title: Routes.getTitleFromRoute(Get.currentRoute),
            ),
            Obx(() {
              switch (controller.selectedIndex.value) {
                case 0:
                  return WebinarView();
                case 1:
                  return OrganisasiView();
                default:
                  return Container(); // Add your default widget here
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: NavBar(controller: controller),
      ),
    );
  }
}
