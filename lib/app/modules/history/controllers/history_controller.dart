import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';

class HistoryController extends GetxController {
  final content = Get.find<ContentController>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    content.readAllHistoryWebinar();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
