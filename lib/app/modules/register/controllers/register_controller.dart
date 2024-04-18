import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterController extends GetxController {
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
