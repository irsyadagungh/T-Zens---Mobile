import 'package:get/get.dart';

import '../controllers/detail_page_organisasi_controller.dart';

class DetailPageOrganisasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPageOrganisasiController>(
      () => DetailPageOrganisasiController(),
    );
  }
}
