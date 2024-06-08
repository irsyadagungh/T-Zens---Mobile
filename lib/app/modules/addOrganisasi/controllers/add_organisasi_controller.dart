import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddOrganisasiController extends GetxController {
  final Rx<TextEditingController> titleController =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> descriptionController =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> linkController =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> date =
      Rx<TextEditingController>(TextEditingController());
  DateTime selectedDate = DateTime.now();
  final Rx<TextEditingController> startDate =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> endDate =
      Rx<TextEditingController>(TextEditingController());
  RxList<TextEditingController> listDivisionController =
      RxList([TextEditingController()]);

  RxList<TextEditingController> listContactNameController =
      RxList([TextEditingController()]);
  RxList<TextEditingController> listContactPhoneController =
      RxList([TextEditingController()]);

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
