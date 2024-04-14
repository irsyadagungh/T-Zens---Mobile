import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddController extends GetxController {
  final List<TextEditingController> listController = [TextEditingController()];
  final List<String> benefits = [];

  late Rx<File?> pickedFile = null.obs;
  File? get getImageFile => pickedFile.value;
  XFile? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      imageFile = await picker.pickImage(source: ImageSource.gallery);

      if (imageFile != null) {
        pickedFile.value = File(imageFile!.path);
        update();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }

    print(imageFile!.path);
  }

  final totalBenefit = 1.obs;
  @override
  void onInit() {
    super.onInit();
    pickedFile = Rx<File?>(null);
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
