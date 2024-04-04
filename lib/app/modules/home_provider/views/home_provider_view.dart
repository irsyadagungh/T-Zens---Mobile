import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/profile/views/profile_view.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/top_app_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../controllers/home_provider_controller.dart';

class HomeProviderView extends GetView<HomeProviderController> {
  HomeProviderView({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    print(auth.user);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar
          TopAppBar(auth: auth),

          // Body
          SliverList(
              delegate: SliverChildListDelegate([
            Text(
              "data",
              style: TextStyle(fontSize: 1000),
            ),
          ]))
        ],
      ),
    );
  }
}
