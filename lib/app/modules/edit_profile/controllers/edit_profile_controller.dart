import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tzens/app/controllers/auth_controller.dart';

class EditProfileController extends GetxController {
  final authC = Get.find<AuthController>();

  /** TEXT CONTROLLER */
  RxBool isEdit = false.obs;
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController nimController;
  late TextEditingController phoneController;
  late SingleValueDropDownController facultyController;
  late SingleValueDropDownController majorController;
  RxList<DropDownValueModel> majorList = RxList<DropDownValueModel>([]);

  /** LIST VARIABEL */
  final List<DropDownValueModel> facultyList = [
    DropDownValueModel(
      name: "Fakultas Teknik Elektro",
      value: "Fakultas Teknik Elektro",
    ),
    DropDownValueModel(
      name: "Fakultas Rekayasa Industri",
      value: "Fakultas Rekayasa Industri",
    ),
    DropDownValueModel(
      name: "Fakultas Informatika",
      value: "Fakultas Informatika",
    ),
    DropDownValueModel(
      name: "Fakultas Ekonomi dan Bisnis",
      value: "Fakultas Ekonomi dan Bisnis",
    ),
    DropDownValueModel(
      name: "Fakultas Komunikasi dan Bisnis",
      value: "Fakultas Komunikasi dan Bisnis",
    ),
    DropDownValueModel(
      name: "Fakultas Industri Kreatif",
      value: "Fakultas Industri Kreatif",
    ),
    DropDownValueModel(
      name: "Fakultas Ilmu Terapan",
      value: "Fakultas Ilmu Terapan",
    ),
  ];

  // FAKULTAS TEKNIK ELEKTRO
  final List<DropDownValueModel> majorElectroList = [
    DropDownValueModel(
      name: "S1 Teknik Elektro",
      value: "S1 Teknik Elektro",
    ),
    DropDownValueModel(
      name: "S1 Teknik Fisika",
      value: "S1 Teknik Fisika",
    ),
    DropDownValueModel(
      name: "S1 Teknik Komputer",
      value: "S1 Teknik Komputer",
    ),
    DropDownValueModel(
      name: "S1 Teknik Biomedis",
      value: "S1 Teknik Biomedis",
    ),
    DropDownValueModel(
      name: "S2 Teknik Elektro",
      value: "S2 Teknik Elektro",
    ),
  ];
  // FAKULTAS REKAYASA INDUSTRI
  final List<DropDownValueModel> majorIndustrialList = [
    DropDownValueModel(
      name: "S1 Teknik Industri",
      value: "S1 Teknik Industri",
    ),
    DropDownValueModel(
      name: "S1 Sistem Informasi",
      value: "S1 Sistem Informasi",
    ),
    DropDownValueModel(
      name: "S1 Teknik Logistik",
      value: "S1 Teknik Logistik",
    ),
    DropDownValueModel(
      name: "S2 Teknik Industri",
      value: "S2 Teknik Industri",
    ),
    DropDownValueModel(
      name: "S2 Sistem Informasi",
      value: "S2 Sistem Informasi",
    ),
  ];
// FAKULTAS INFORMATIKA
  final List<DropDownValueModel> majorInformaticsList = [
    DropDownValueModel(
      name: "S1 Informatika",
      value: "S1 Informatika",
    ),
    DropDownValueModel(
      name: "S1 Teknologi Informasi",
      value: "S1 Teknologi Informasi",
    ),
    DropDownValueModel(
      name: "S1 Rekayasa Perangkat Lunak",
      value: "S1 Rekayasa Perangkat Lunak",
    ),
    DropDownValueModel(
      name: "S1 PJJ Informatika",
      value: "S1 PJJ Informatika",
    ),
    DropDownValueModel(
      name: "S1 Sains Data",
      value: "S1 Sains Data",
    ),
    DropDownValueModel(
      name: "S2 Informatika",
      value: "S2 Informatika",
    ),
    DropDownValueModel(
      name: "S2 Ilmu Forensik",
      value: "S2 Ilmu Forensik",
    ),
    DropDownValueModel(
      name: "S3 Informatika",
      value: "S3 Informatika",
    ),
  ];
// FAKULTAS EKONOMI DAN BISNIS
  final List<DropDownValueModel> majorEconomyAndBusinessList = [
    DropDownValueModel(
      name: "S1 Manajemen Bisnis Telekomunikasi Informatika",
      value: "S1 Manajemen Bisnis Telekomunikasi Informatika",
    ),
    DropDownValueModel(
      name: "S1 Akuntansi",
      value: "S1 Akuntansi",
    ),
    DropDownValueModel(
      name: "S2 Manajemen",
      value: "S2 Manajemen",
    ),
    DropDownValueModel(
      name: "S2 PJJ Manajemen",
      value: "S2 PJJ Manajemen",
    ),
  ];
// FAKULTAS KOMUNIKASI DAN BISNIS
  final List<DropDownValueModel> majorCommunicationAndBusinessList = [
    DropDownValueModel(
      name: "S1 Administrasi Bisnis",
      value: "S1 Administrasi Bisnis",
    ),
    DropDownValueModel(
      name: "S1 Ilmu Komunikasi",
      value: "S1 Ilmu Komunikasi",
    ),
    DropDownValueModel(
      name: "S1 Hubungan Masyarakat Digital",
      value: "S1 Hubungan Masyarakat Digital",
    ),
  ];
// FAKULTAS INDUSTRI KREATIF
  final List<DropDownValueModel> majorIndustriKreatifList = [
    DropDownValueModel(
      name: "S1 Desain Komunikasi Visual",
      value: "S1 Desain Komunikasi Visual",
    ),
    DropDownValueModel(
      name: "S1 Desain Produk",
      value: "S1 Desain Produk",
    ),
    DropDownValueModel(
      name: "S1 Desain Interior",
      value: "S1 Desain Interior",
    ),
    DropDownValueModel(
      name: "S1 Kriya Tekstil dan Fashion",
      value: "S1 Kriya Tekstil dan Fashion",
    ),
    DropDownValueModel(
      name: "S1 Seni Rupa",
      value: "S1 Seni Rupa",
    ),
    DropDownValueModel(
      name: "S2 Desain",
      value: "S2 Desain",
    ),
  ];
// FAKULTAS ILMU TERAPAN
  final List<DropDownValueModel> majorFITList = [
    DropDownValueModel(
      name: "D3 Teknologi Telekomunikasi",
      value: "D3 Teknologi Telekomunikasi",
    ),
    DropDownValueModel(
      name: "D3 Rekayasa Perangkat Lunak Aplikasi",
      value: "D3 Rekayasa Perangkat Lunak Aplikasi",
    ),
    DropDownValueModel(
      name: "D3 Sistem Informasi",
      value: "D3 Sistem Informasi",
    ),
    DropDownValueModel(
      name: "D3 Sistem Informasi Akuntansi",
      value: "D3 Sistem Informasi Akuntansi",
    ),
    DropDownValueModel(
      name: "D3 Teknologi Komputer",
      value: "D3 Teknologi Komputer",
    ),
    DropDownValueModel(
      name: "D3 Manajemen Pemasaran",
      value: "D3 Manajemen Pemasaran",
    ),
    DropDownValueModel(
      name: "D3 Perhotelan",
      value: "D3 Perhotelan",
    ),
    DropDownValueModel(
      name: "D4 Teknologi Rekayasa Multimedia",
      value: "D4 Teknologi Rekayasa Multimedia",
    ),
  ];

  /** START DROPDOWN LOGIC */
  void onFacultyChange(DropDownValueModel? value) {
    print("FAKULTASNYA = ${value?.name}");
    update();
    if (value == null) {
      majorList.value = [];
      majorController.clearDropDown();
      print(" JURUSANNYA = ${majorController.dropDownValue}");
    } else {
      switch (value.name) {
        case "Fakultas Teknik Elektro":
          majorList.value = majorElectroList;
          break;
        case "Fakultas Rekayasa Industri":
          majorList.value = majorIndustrialList;
          break;
        case "Fakultas Informatika":
          majorList.value = majorInformaticsList;
          break;
        case "Fakultas Ekonomi dan Bisnis":
          majorList.value = majorEconomyAndBusinessList;
          break;
        case "Fakultas Komunikasi dan Bisnis":
          majorList.value = majorCommunicationAndBusinessList;
          break;
        case "Fakultas Industri Kreatif":
          majorList.value = majorIndustriKreatifList;
          break;
        case "Fakultas Ilmu Terapan":
          majorList.value = majorFITList;
          break;
      }
    }
    update();
  }
  /** END DROPDOWN LOGIC */

  /** START UPLOAD IMAGE */
  RxString picLink = "".obs;
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
  /** END UPLOAD IMAGE */

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: authC.user.value.name);
    usernameController = TextEditingController(text: authC.user.value.username);
    emailController = TextEditingController(text: authC.user.value.email);
    nimController = TextEditingController(text: authC.user.value.nim ?? "");
    facultyController = authC.user.value.faculty != ""
        ? SingleValueDropDownController(
            data: DropDownValueModel(
              name: "${authC.user.value.faculty}",
              value: authC.user.value.faculty ?? "",
            ),
          )
        : SingleValueDropDownController();
    majorController = SingleValueDropDownController(
      data: DropDownValueModel(
        name: "${authC.user.value.major}",
        value: authC.user.value.major ?? "",
      ),
    );
    phoneController = TextEditingController(text: authC.user.value.phone ?? "");
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
