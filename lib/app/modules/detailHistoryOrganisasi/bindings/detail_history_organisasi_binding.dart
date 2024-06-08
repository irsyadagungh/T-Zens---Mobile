import 'package:get/get.dart';

import '../controllers/detail_history_organisasi_controller.dart';

class DetailHistoryOrganisasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHistoryOrganisasiController>(
      () => DetailHistoryOrganisasiController(),
    );
  }
}
