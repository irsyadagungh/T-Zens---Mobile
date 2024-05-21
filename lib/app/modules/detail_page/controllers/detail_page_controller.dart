import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/messages.dart';

class DetailPageController extends GetxController {
  //TODO: Implement DetailPageController

  AuthController authC = Get.find<AuthController>();
  Messages messageC = Get.find<Messages>();

  final count = 0.obs;
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

  final adminToken = 'admin-fcm-token-here'; // Replace with the actual token
  final title = 'Webinar Update';
  final body = 'The webinar will start in 10 minutes.';



  @override
  void onInit() {
    super.onInit();
    checkDisabled();
    print(authC.user.value.role);
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
