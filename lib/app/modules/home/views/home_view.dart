import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  AuthController? auth;

  @override
  Widget build(BuildContext context) {
    auth = Get.find<AuthController>();

    if (auth == null || auth!.user == null) {
      // Handle the case where auth or auth.user is null
      return CircularProgressIndicator(); // or any other placeholder widget
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "${auth!.user!.name}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
