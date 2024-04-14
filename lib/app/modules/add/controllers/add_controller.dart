import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddController extends GetxController {
  final List<TextEditingController> listController = [TextEditingController()];
  final List<String> benefits = [];

  Rx<File?> imageFile =
      Rx<File?>(null); // Gunakan Rx<File?> untuk memantau perubahan imageFile
  final picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile.value =
            File(pickedFile.path); // Set nilai imageFile menggunakan value
        update(); // Perbarui UI setelah memilih gambar
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }
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
