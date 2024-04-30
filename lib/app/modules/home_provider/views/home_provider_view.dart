import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/add/views/add_view.dart';
import 'package:tzens/app/modules/detailPage/views/detail_page_view.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/screen/webinar_provider.dart';
import 'package:tzens/app/utils/widget/top_app_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../controllers/home_provider_controller.dart';

class HomeProviderView extends GetView<HomeProviderController> {
  final auth = Get.find<AuthController>();
  final webinar = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      backgroundColor: customWhite,
      body: CustomScrollView(
        slivers: [
          TopAppBar(
            auth: auth,
            title: Routes.getTitleFromRoute(Get.currentRoute),
          ),
          // WebinarProvider(webinar: webinar)
          _buildSliverWidget()
        ],
      ),
      bottomNavigationBar: Obx(
        () => WaterDropNavBar(
            bottomPadding: 20,
            waterDropColor: Theme.of(context).colorScheme.primary,
            barItems: [
              BarItem(
                  filledIcon: Icons.event, outlinedIcon: Icons.event_outlined),
              BarItem(
                  filledIcon: Icons.group, outlinedIcon: Icons.group_outlined),
              BarItem(
                  filledIcon: Icons.person, outlinedIcon: Icons.person_outlined)
            ],
            selectedIndex: controller.selectedIndex.value,
            onItemSelected: (index) {
              controller.selectedIndex.value = index;
              print(controller.selectedIndex.value);
            }),
      ),
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
            onPressed: () {},
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
  final webinar = Get.find<ContentController>();

  return Obx(() {
    switch (controller.selectedIndex.value) {
      case 0:
        // Mengembalikan widget untuk kasus 0
        return WebinarProvider(webinar: webinar);
      case 1:
        // Mengembalikan widget untuk kasus 1
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.amber,
            height: 250,
          ),
        );
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
