import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profil_page_controller.dart';

class ProfilPageView extends GetView<ProfilPageController> {
  const ProfilPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfilPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
