import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/data/models/user_model_model.dart';
import 'package:tzens/app/data/models/user_model_model.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/home_provider/views/home_provider_view.dart';

class ContentController extends GetxController {
  final authC = Get.find<AuthController>();

  RxString collection = "".obs;

  late CollectionReference dbUser =
      FirebaseFirestore.instance.collection("users");
  late CollectionReference dbWebinar =
      FirebaseFirestore.instance.collection("webinar");
  late CollectionReference dbOrganization =
      FirebaseFirestore.instance.collection("organization");
  late Reference storage = FirebaseStorage.instance.ref();
  RxString picLink = "".obs;
  RxInt length = 0.obs;

  WebinarModel content = WebinarModel();
  RxList<WebinarModel> contentListProvider = RxList<WebinarModel>([]);
  RxList<OrganizationModel> contentListOrganizationProvider =
      RxList<OrganizationModel>([]);
  RxList<WebinarModel> contentListUser = RxList<WebinarModel>([]);
  RxList<WebinarModel> contentListSearch = RxList<WebinarModel>([]);
  RxList<WebinarModel> bookmarkedWebinars = RxList<WebinarModel>([]);

  RxList<WebinarModel> historyNotStarted = RxList<WebinarModel>([]);
  RxList<WebinarModel> historyStarted = RxList<WebinarModel>([]);

  /** SEARCH */
  /** SEARCH */
  Future<void> search(String keyword) async {
    try {
      final result = await dbWebinar
          .where('title', isGreaterThanOrEqualTo: keyword)
          .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
          .get();

      if (result.docs.isEmpty) {
        print("No data found for keyword: $keyword");
        // Handle empty data scenario (show a message, etc.)
        return;
      } else {
        contentListSearch.clear();
      }

      result.docs.forEach((element) {
        contentListSearch
            .add(WebinarModel.fromJson(element.data() as Map<String, dynamic>));
      });

      print("Data found for keyword: $keyword");
      print(contentListProvider.toString());
      update(); // Memperbarui tampilan setelah menambahkan data ke contentList
    } catch (e) {
      print("ERROR SEARCH DATA: $e");
    }
  }

  /** UPLOAD IMAGE */
  Future<void> uploadImage(File imageFile, String name) async {
    try {
      final path = "webinar/${name}";
      final file = File(imageFile.path);

      final ref = storage.child(path);
      final uploadTask = ref.putFile(file);

      // Menunggu hingga proses upload selesai
      await uploadTask.whenComplete(() async {
        picLink.value = await ref.getDownloadURL();
      });

      // Setelah proses upload selesai, picLink.value sudah diupdate
      print("Image uploaded with link = " + picLink.value);
    } catch (e) {
      print("ERROR UPLOAD" + e.toString());
    }
  }

  /** ADD DATA WEBINAR */
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
      DocumentReference docRef = await dbWebinar.add({
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
        "registeredAccount": [""],
        "status": status,
        "time": time,
        "title": title,
        "updatedAt": "",
      });

      String docId = docRef.id;

      try {
        await dbWebinar.doc(docId).update({
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

  /** READ DATA PROVIDER */
  Future<void> readDataProvider() async {
    try {
      final result = await dbWebinar
          .where('administrator.uid', isEqualTo: authC.user.value.uid)
          .get();

      if (result.docs.isEmpty) {
        print("No data found for current user.");
        // Handle empty data scenario (show a message, etc.)
        return;
      }

      contentListProvider.value = result.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      update();
    } catch (e) {
      print("ERROR READ DATA WEBINAR PROVIDER : " + e.toString());
    }
  }

  /** READ DATA USER */
  Future<void> readDataUser() async {
    try {
      final result = await dbWebinar.get();

      if (result.docs.isEmpty) {
        print("No data found for current user.");
        // Handle empty data scenario (show a message, etc.)
        return;
      }

      contentListUser.value = result.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      print(contentListUser.toString() + "tESTINGGGGG");
    } catch (e) {
      print("ERROR READ DATA" + e.toString());
    }
  }

  /** BOOKMARK */
  Future<void> readBookmarkedWebinars() async {
    try {
      List<dynamic> id = authC.user.value.bookmark!;
      print("ID BOOKMARK: $id");

      final result = await dbWebinar.get();
      bookmarkedWebinars.value = result.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .where((element) => id.contains(element.id))
          .toList();
    } catch (e) {
      print("ERROR READING BOOKMARKED WEBINARS: $e");
    }
  }

  /** DELETE DATA WEBINAR */
  Future<void> deleteData(String id) async {
    try {
      await dbWebinar.doc(id).delete();
      print("Data deleted");
      Get.back();
      Get.back();
    } catch (e) {
      print("ERROR DELETE DATA" + e.toString());
    }
  }

  /** REGISTER WEBINAR */
  Future<void> registerWebinar(String idWebinar, String uid) async {
    try {
      await dbWebinar.doc(idWebinar).update({
        "registeredAccount": FieldValue.arrayUnion([uid])
      });

      await dbUser.doc(uid).update({
        "registeredWebinar": FieldValue.arrayUnion([idWebinar])
      });

      print("Registered to webinar");
    } catch (e) {
      print("ERROR REGISTER WEBINAR" + e.toString());
    }
  }

  /** READ HISTORY WEBINAR */
  Future<void> readHistoryWebinar() async {
    try {
      final date = DateTime.now();
      final idUser = authC.user.value.uid;

      // Query for upcoming webinars
      final upcomingWebinars = await dbWebinar
          .where('registeredAccount', arrayContains: idUser)
          .where('date',
              isGreaterThan: DateFormat.yMd().format(date).toString())
          .get();

      historyNotStarted.value = upcomingWebinars.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      print("HISTORY NOT STARTED: ${historyNotStarted.value}");

      // Query for past webinars
      final pastWebinars = await dbWebinar
          .where('registeredAccount', arrayContains: idUser)
          .where('date',
              isLessThanOrEqualTo: DateFormat.yMd().format(date).toString())
          .get();

      historyStarted.value = pastWebinars.docs
          .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      print("HISTORY STARTED: ${historyStarted.value}");
    } catch (e) {
      print('Error: $e');
    }
  }

  /** ADD ORGANIZATION */
  Future<void> addOrganization(
    Map<String, dynamic> administrator,
    List<String> division,
    String timestamp,
    List<Map<String, dynamic>> contact,
    Map<String, dynamic> date,
    String description,
    String link,
    String photoUrl,
    String title,
  ) async {
    try {
      DocumentReference docRef = await dbOrganization.add({
        "administrator": administrator,
        "createdAt": timestamp,
        "contact": contact,
        "description": description,
        "division": division,
        "link": link,
        "open_recruitment": null,
        "photoUrl": photoUrl,
        "registered_account": [],
        "title": title,
        "updatedAt": "",
      });

      String docId = docRef.id;

      try {
        await dbOrganization.doc(docId).update({
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

  /** READ DATA ORGANIZATION */
  Future<void> readDataOrganization() async {
    try {
      final idUser = authC.user.value.uid;
      final result = await dbOrganization
          .where('administrator.uid', isEqualTo: idUser)
          .get();

      if (result.docs.isEmpty) {
        print("No data found for current user.");
        // Handle empty data scenario (show a message, etc.)
        return;
      }

      // Reset the list before adding new data
      contentListOrganizationProvider.value.clear();
      contentListOrganizationProvider.value = result.docs
          .map((e) =>
              OrganizationModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      print(contentListOrganizationProvider.toString() + "ORGANIZATION DATA");
    } catch (e) {
      print("ERROR READ DATA" + e.toString());
    }
  }

/** DELETE DATA ORGANIZATION */
  Future<void> deleteDataOrganization(String id) async {
    try {
      await dbOrganization.doc(id).delete();
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
