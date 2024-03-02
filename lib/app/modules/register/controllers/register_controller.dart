import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tzens/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  void showPopupDialog() {
    Get.defaultDialog(
      title: "Register Success",
      content: Lottie.asset("assets/lottie/done.json"),
    );

    // Menutup dialog setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      Get.back();
    });
  }
}
