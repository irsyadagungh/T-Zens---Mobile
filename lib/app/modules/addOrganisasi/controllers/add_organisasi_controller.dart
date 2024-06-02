import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddOrganisasiController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final List<TextEditingController> listDivisionController = [
    TextEditingController()
  ];

  final List<TextEditingController> listContactNameController = [
    TextEditingController()
  ];
  final List<TextEditingController> listContactPhoneController = [
    TextEditingController()
  ];

  Rx<File?> imageFile = Rx<File?>(null); // Initialize with null
  final picker = ImagePicker();
  XFile? pickedFile = null;

  Future<void> pickImage() async {
    try {
      // PermissionStatus permission = await Permission.photos.request();
      // if (await permission.isGranted) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      // } else if (await permission.isDenied) {
      //   await Permission.photos.request();
      // }

      if (pickedFile != null) {
        imageFile.value = File(pickedFile!.path);
        update();
      } else {
        imageFile.value = null; // Set to null if no image is selected
        print('No image selected.');
      }

      print(imageFile.value?.path); // Use ?. operator to avoid null errors
    } catch (e) {
      print(e);
    }
  }

  final totalDivision = 1.obs;
  final totalPrasyarat = 1.obs;
  final totalContact = 1.obs;

  final count = 0.obs;
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

  void increment() => count.value++;

  void benefitIncrement() => totalDivision.value++;
  void benefitDecrement() => totalDivision.value--;
  void contactIncrement() => totalContact.value++;
  void contactDecrement() => totalContact.value--;
}
