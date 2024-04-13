import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddController extends GetxController {
  final List<TextEditingController> listController = [TextEditingController()];
  final List<String> benefits = [];

  Rx<File>? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage() async {
  try {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path).obs;
      update();
    } else {
      print('No image selected.');
    }
  } catch (e) {
    print(e);
  }

  print(imageFile.toString());
}

  final totalBenefit = 1.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => totalBenefit.value++;
  void decrement() => totalBenefit.value--;
}
