import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';

class DetailPageOrganisasiController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  RxBool isDisabled = true.obs;

  bool checkDisabled() {
    if (authC.user.value.role == "provider") {
      return isDisabled.value = true;
    } else if (authC.user.value.faculty == "" ||
        authC.user.value.major == "" ||
        authC.user.value.nim == "" ||
        authC.user.value.phone == "") {
      return isDisabled.value = true;
    } else {
      return isDisabled.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    checkDisabled();
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
