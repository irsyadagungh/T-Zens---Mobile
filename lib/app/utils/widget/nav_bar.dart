import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/modules/home_provider/controllers/home_provider_controller.dart';
import 'package:tzens/app/modules/profile/views/profile_view.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.controller,
  });

  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WaterDropNavBar(
          bottomPadding: 20,
          waterDropColor: Theme.of(context).colorScheme.primary,
          barItems: [
            BarItem(
              filledIcon: Icons.event,
              outlinedIcon: Icons.event_outlined,
            ),
            BarItem(
              filledIcon: Icons.group,
              outlinedIcon: Icons.group_outlined,
            ),
            BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_outlined,
            ),
          ],
          selectedIndex: controller.selectedIndex.value,
          onItemSelected: (index) {
            if (index != 2) {
              // Jika bukan tombol profile yang diklik
              controller.selectedIndex.value = index;
            } else {
              // Jika tombol profile yang diklik
              Get.to(() => ProfileView());
            }
            print(controller.selectedIndex.value);
          }),
    );
  }
}