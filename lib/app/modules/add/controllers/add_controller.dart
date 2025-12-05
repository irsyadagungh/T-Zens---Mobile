import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';

class AddController extends GetxController {
  final List<String> benefits = [];
  final List<String> prasyarat = [];
  final Map<String, dynamic> contact = Contact().toJson();
  List<Map<String, dynamic>> contactList = [];

  late WebinarModel webinarModel =
      WebinarModel(); // Field untuk menyimpan WebinarModel

  void setModel(WebinarModel newModel) {
    webinarModel = newModel;
    update();
  }

  

  final TextEditingController date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();

  DateTime formatDate() {
    DateFormat.yMd().format(selectedDate);
    return selectedDate;
  }

  RxList<String> eventType = ["Online", "Offline"].obs;

  final Rx<TextEditingController> name =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> phone =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> titleController =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> descriptionController =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> linkController =
      Rx<TextEditingController>(TextEditingController());
  final Rx<TextEditingController> locationController =
      Rx<TextEditingController>(TextEditingController());

   RxList<TextEditingController> listBenefitController =
      RxList([TextEditingController()]);
   RxList<TextEditingController> listPrasyaratController =
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
