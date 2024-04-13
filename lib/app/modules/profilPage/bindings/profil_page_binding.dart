import 'package:get/get.dart';

import '../controllers/profil_page_controller.dart';

class ProfilPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilPageController>(
      () => ProfilPageController(),
    );
  }
}
