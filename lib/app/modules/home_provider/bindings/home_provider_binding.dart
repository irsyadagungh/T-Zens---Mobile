import 'package:get/get.dart';

import '../controllers/home_provider_controller.dart';

class HomeProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeProviderController>(
      () => HomeProviderController(),
    );
  }
}
