import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';

class ContentController extends GetxController {
  final auth = Get.find<AuthController>();

  RxString collection = "".obs;

  String setCollection(String value) {
    switch (value) {
      case '/add':
        collection.value = 'webinar';
        break;
      case '/profile':
        collection.value = 'organisasi';
        break;
      // Tambahkan case lainnya sesuai dengan rute yang Anda miliki
      default:
        setCollection('defaultCollection');
    }

    return collection.value;
  }

  late CollectionReference db =
      FirebaseFirestore.instance.collection("webinar");
  late Reference storage = FirebaseStorage.instance.ref();
  final RxString picLink = "".obs;

  WebinarModel content = WebinarModel();

// UPLOAD IMAGE
  Future<void> uploadImage(File imageFile, String name) async {
    try {
      final path = "webinar/${name}";
      final file = File(imageFile.path);

      final ref = storage.child(path);
      ref.putFile(file).then((value) async {
        picLink.value = await value.ref.getDownloadURL();
      });

      print(picLink.value);
      print("Image uploaded");
    } catch (e) {
      print("ERROR UPLOAD" + e.toString());
    }
  }

  // ADD DATA
  Future<void> addData(
    List<String> benefits,
    String description,
    List<Map<String, dynamic>> contact,
    Map<String, dynamic> administrator,
    String photoUrl,
    List<String> prerequisite,
    String title,
    String location,
    String timestamp,
  ) async {
    try {
      // content = WebinarModel(
      //   benefits: benefits,
      //   description: description,
      //   contact: contact,
      //   administrator: administrator,
      //   photo: photoUrl,
      //   prerequisite: prerequisite,
      //   title: title,
      //   location: location,
      // );

      await db.add({
        "administrator": administrator,
        "benefits": benefits,
        "contact": contact,
        "description": description,
        "location": location,
        "photo": photoUrl,
        "prerequisite": prerequisite,
        "title": title,
        "timestamp": timestamp,
      });

      print(content.toJson());
      print("Data added");
    } catch (e) {
      print(e);
    }
  }

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
}
