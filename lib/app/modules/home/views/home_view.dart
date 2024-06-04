import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/screen/organisasi_Screen.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';
import 'package:tzens/app/utils/widget/nav_bar.dart';
import 'package:tzens/app/utils/widget/top_app_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final controller = Get.put(HomeController());
    final pageController = PageController();

    if (auth == null || auth!.user == null) {
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
              auth: auth,
              title: Routes.getTitleFromRoute(Get.currentRoute),
            ),
            Obx(() {
              switch (controller.currentPages.value) {
                case 0:
                  return OrganisasiView();
                case 1:
                  return WebinarView();
                default:
                  return Container(); // Add your default widget here
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(controller: controller),
    );
  }
}
