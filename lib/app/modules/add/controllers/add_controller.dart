import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';

class AddController extends GetxController {
  final List<String> benefits = [];
  final List<String> prasyarat = [];
  final Map<String, dynamic> contact = Contact().toJson();
  List<Map<String, dynamic>> contactList = [];

  @override
  void onInit() {
    super.onInit();
    print(titleController.text);
    print("title");
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final List<TextEditingController> listBenefitController = [
    TextEditingController()
  ];
  final List<TextEditingController> listPrasyaratController = [
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
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

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

  void removeImage() {
    imageFile.value = null;
    update();
  }

  final totalBenefit = 1.obs;
  final totalPrasyarat = 1.obs;
  final totalContact = 1.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void benefitIncrement() => totalBenefit.value++;
  void benefitDecrement() => totalBenefit.value--;
  void prasyaratIncrement() => totalPrasyarat.value++;
  void prasyaratDecrement() => totalPrasyarat.value--;
  void contactIncrement() => totalContact.value++;
  void contactDecrement() => totalContact.value--;
}
