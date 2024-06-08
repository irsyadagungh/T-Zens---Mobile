import 'package:get/get.dart';

import '../controllers/history_page_organization_controller.dart';

class HistoryPageOrganizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPageOrganizationController>(
      () => HistoryPageOrganizationController(),
    );
  }
}
