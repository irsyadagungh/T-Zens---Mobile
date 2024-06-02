import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/modules/add/views/add_view.dart';
import 'package:tzens/app/modules/addOrganisasi/views/add_organisasi_view.dart';
import 'package:tzens/app/modules/profile/views/profile_view.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/screen/organisasi_provider.dart';
import 'package:tzens/app/utils/screen/webinar_providers.dart';
import 'package:tzens/app/utils/widget/nav_bar.dart';
import 'package:tzens/app/utils/widget/top_app_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../controllers/home_provider_controller.dart';

class HomeProviderView extends GetView<HomeProviderController> {
  final auth = Get.find<AuthController>();
  final webinar = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    webinar.readDataProvider();
    webinar.readDataOrganization();
    print(Get.currentRoute);
    return Scaffold(
      backgroundColor: customWhite,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          controller.onInit();
        },
        child: CustomScrollView(
          slivers: [
            TopAppBar(
              auth: auth,
              title: Routes.getTitleFromRoute(Get.currentRoute),
            ),
            // WebinarProvider(webinar: webinar, controller: controller)
            _buildSliverWidget()
          ],
        ),
      ),
      bottomNavigationBar: NavBar(controller: controller),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: [
          FloatingActionButton(
            heroTag: 'add_event',
            onPressed: () {
              Get.to(() => AddView());
            },
            tooltip: 'Add Event',
            child: Icon(Icons.event_note),
          ),
          FloatingActionButton(
            heroTag: 'add_group',
            onPressed: () {
              Get.to(() => AddOrganisasiView());
            },
            tooltip: 'Add Group',
            child: Icon(Icons.group_add),
          ),
        ],
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }
}

Widget _buildSliverWidget() {
  final controller = Get.find<HomeProviderController>();
  final content = Get.find<ContentController>();

  return Obx(() {
    switch (controller.selectedIndex.value) {
      case 0:
        // Mengembalikan widget untuk kasus 0
        return WebinarProviders(webinar: content, controller: controller);
      case 1:
        // Mengembalikan widget untuk kasus 1
        return OrganisasiProvider(organisasi: content, controller: controller);
      default:
        // Mengembalikan widget default jika selectedIndex tidak cocok dengan kasus apa pun
        return SliverToBoxAdapter(
          child: Container(
              // Widget default
              ),
        );
    }
  });
}
