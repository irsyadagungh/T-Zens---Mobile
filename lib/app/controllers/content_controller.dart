import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/home_provider/views/home_provider_view.dart';

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
  RxString picLink = "".obs;
  RxInt length = 0.obs;

  WebinarModel content = WebinarModel();
  RxList<WebinarModel> contentList = RxList<WebinarModel>([]);
  RxList<WebinarModel> contentList2 = RxList<WebinarModel>([]);

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
    Map<String, dynamic> administrator,
    List<String> benefits,
    String timestamp,
    List<Map<String, dynamic>> contact,
    String date,
    String description,
    String link,
    String location,
    String photoUrl,
    List<String> prerequisite,
    String status,
    Map<String, dynamic> time,
    String title,
  ) async {
    try {
      DocumentReference docRef = await db.add({
        "administrator": administrator,
        "benefits": benefits,
        "createdAt": timestamp,
        "contact": contact,
        "date": date,
        "description": description,
        "id": "",
        "link": "",
        "location": location,
        "photo": photoUrl,
        "prerequisite": prerequisite,
        "status": status,
        "time": time,
        "title": title,
        "updatedAt": "",
      });

      String docId = docRef.id;

      try {
        await db.doc(docId).update({
          "id": docId,
        });
        print("ID BARU :" + docId);
        print("DATA ADDED");
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  // READ DATA
  Future<void> readDataProvider() async {
    try {
      final result =
          await db.where('administrator.uid', isEqualTo: auth.user.uid).get();

      if (result.docs.isEmpty) {
        print("No data found for current user.");
        // Handle empty data scenario (show a message, etc.)
        return;
      }

      contentList.value = result.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("ERROR READ DATA" + e.toString());
    }
  }

  Future<void> readDataUser() async {
    try {
      final result = await db.get();

      if (result.docs.isEmpty) {
        print("No data found for current user.");
        // Handle empty data scenario (show a message, etc.)
        return;
      }

      contentList.value = result.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      print(contentList.toString() + "tESTINGGGGG");
    } catch (e) {
      print("ERROR READ DATA" + e.toString());
    }
  }

  Future<void> deleteData(String id) async {
    try {
      await db.doc(id).delete();
      print("Data deleted");
      Get.back();
      Get.back();
    } catch (e) {
      print("ERROR DELETE DATA" + e.toString());
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
