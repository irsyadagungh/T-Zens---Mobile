import 'package:get/get.dart';

import '../controllers/bookmark_user_controller.dart';

class BookmarkUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkUserController>(
      () => BookmarkUserController(),
    );
  }
}
