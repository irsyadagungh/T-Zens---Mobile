import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';

class BookmarkController extends GetxController {
  final content = Get.find<ContentController>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    content.readBookmarkedWebinars();
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
