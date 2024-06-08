import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';

class HistoryPageOrganizationController extends GetxController {
  final content = Get.find<ContentController>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    content.readOrganizationHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
