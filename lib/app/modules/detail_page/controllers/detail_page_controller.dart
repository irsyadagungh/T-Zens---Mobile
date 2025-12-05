import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/messages.dart';

class DetailPageController extends GetxController {
  //TODO: Implement DetailPageController

  AuthController authC = Get.find<AuthController>();
  Messages messageC = Get.put(Messages());
  ContentController contentC = Get.put(ContentController());
  final argument = Get.arguments;

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

  @override
  void onInit() {
    super.onInit();
    String id = argument as String;
    checkDisabled();
    print(authC.user.value.role);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final users = await contentC.readRegisteredUserByWebinar(id);
      contentC.registeredUsers.assignAll(users);
      print("Registered Users: ${contentC.registeredUsers.length}");
    });
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    contentC.registeredUsers.clear();
  }

  void increment() => count.value++;
}
