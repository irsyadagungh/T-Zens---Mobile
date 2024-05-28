import 'package:get/get.dart';

import '../controllers/detail_history_controller.dart';

class DetailHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHistoryController>(
      () => DetailHistoryController(),
    );
  }
}
