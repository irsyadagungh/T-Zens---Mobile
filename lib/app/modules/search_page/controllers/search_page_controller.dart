import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';

class SearchPageController extends GetxController {
  //TODO: Implement SearchPageController
  final contentController = Get.find<ContentController>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    contentController.contentListSearch.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
