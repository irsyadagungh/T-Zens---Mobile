import 'package:get/get.dart';

import '../controllers/add_organisasi_controller.dart';

class AddOrganisasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrganisasiController>(
      () => AddOrganisasiController(),
    );
  }
}
