import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/data/models/user_model_model.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/home_provider/views/home_provider_view.dart';
import 'package:tzens/app/utils/function/SnackBar.dart';

class ContentController extends GetxController {
  RxBool isEdit = false.obs;

  final authC = Get.find<AuthController>();
  WebinarModel webinarModel = WebinarModel();
  OrganizationModel organizationModel = OrganizationModel();

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
  RxList<OrganizationModel> contentListOrganizationUser =
      RxList<OrganizationModel>([]);
  RxList<OrganizationModel> contentListOrganizationProvider =
      RxList<OrganizationModel>([]);
  RxList<WebinarModel> contentListUser = RxList<WebinarModel>([]);
  RxList<WebinarModel> contentListSearch = RxList<WebinarModel>([]);
  RxList<WebinarModel> bookmarkedWebinars = RxList<WebinarModel>([]);

  RxList<WebinarModel> historyNotStarted = RxList<WebinarModel>([]);
  RxList<WebinarModel> historyStarted = RxList<WebinarModel>([]);

  RxList<WebinarModel> historyNotStarted2 = RxList<WebinarModel>([]);
  RxList<WebinarModel> historyStarted2 = RxList<WebinarModel>([]);

  RxList<RegisteredAccount> accountImage = <RegisteredAccount>[].obs;

  /** SEARCH */
  Future<void> search(String keyword) async {
    try {
      final result = await dbWebinar
          .where('title', isGreaterThanOrEqualTo: keyword)
          .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
          .get();

      if (result.docs.isEmpty) {
        print("No data found for keyword: $keyword");
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
  Future<void> uploadImage(
      File imageFile, String name, String storageName) async {
    try {
      final path = "${storageName}/${name}";
      final file = File(imageFile.path);

      final ref = storage.child(path);
      final uploadTask = ref.putFile(file);

      await uploadTask.whenComplete(() async {
        picLink.value = await ref.getDownloadURL();
      });

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
        "link": link,
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

  /** UPDATE DATA WEBINAR */
  Future<void> updateData(
    String id,
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
      await dbWebinar.doc(id).update({
        "administrator": administrator,
        "benefits": benefits,
        "createdAt": timestamp,
        "contact": contact,
        "date": date,
        "description": description,
        "link": link,
        "location": location,
        "photo": photoUrl,
        "prerequisite": prerequisite,
        "status": status,
        "time": time,
        "title": title,
        "updatedAt": timestamp,
      });

      print("Data updated");
    } catch (e) {
      print("ERROR UPDATE DATA" + e.toString());
    }
  }

  /** READ DATA PROVIDER */
  void readDataProvider() {
    try {
      dbWebinar
          .where('administrator.uid', isEqualTo: authC.user.value.uid)
          .snapshots()
          .listen((result) {
        if (result.docs.isEmpty) {
          print("No data found for current user.");
          contentListProvider.clear();
          return;
        }

        contentListProvider.value = result.docs
            .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();

        update();
      });
    } catch (e) {
      print("ERROR READ DATA WEBINAR PROVIDER : " + e.toString());
    }
  }

  /** READ DATA USER */
  void readDataUser() {
    try {
      dbWebinar.snapshots().listen((result) {
        if (result.docs.isEmpty) {
          print("No data found for current user.");
          contentListUser.clear();
          return;
        }

        contentListUser.value = result.docs
            .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        print(contentListUser.toString() + "tESTINGGGGG");
      });
    } catch (e) {
      print("ERROR READ DATA" + e.toString());
    }
  }

  /** BOOKMARK */
  void readBookmarkedWebinars() {
    try {
      List<dynamic> id = authC.user.value.bookmark!;
      print("ID BOOKMARK: $id");

      dbWebinar.snapshots().listen((result) {
        bookmarkedWebinars.value = result.docs
            .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
            .where((element) => id.contains(element.id))
            .toList();
      });
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
      // Mengecek apakah user sudah terdaftar di webinar
      if (contentListUser
          .where((element) => element.id == idWebinar)
          .first
          .registeredAccount!
          .contains(uid)) {
        print("User already registered to this webinar.");
        CustomSnackBar(
            "Registered!",
            "You are already registered to this webinar",
            Icons.warning_amber_rounded,
            Colors.red);
      } else {
        await dbWebinar.doc(idWebinar).update({
          "registeredAccount": FieldValue.arrayUnion([uid])
        });

        await dbUser.doc(uid).update({
          "registeredWebinar": FieldValue.arrayUnion([idWebinar])
        });

        CustomSnackBar(
          "Success",
          "You are registered to webinar",
          Icons.check,
          Colors.green,
        );
      }

      print("Registered to webinar");
    } catch (e) {
      print("ERROR REGISTER WEBINAR" + e.toString());
    }
  }

  /** READ HISTORY WEBINAR */
  void readHistoryWebinar() {
    try {
      final date = DateTime.now();
      final idUser = authC.user.value.uid;

      // Query for upcoming webinars
      dbWebinar
          .where('registeredAccount', arrayContains: idUser)
          .where('date',
              isGreaterThan: DateFormat.yMd().format(date).toString())
          .snapshots()
          .listen((upcomingWebinars) {
        historyNotStarted.value = upcomingWebinars.docs
            .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        print("HISTORY NOT STARTED: ${historyNotStarted.value}");
      });

      // Query for past webinars
      dbWebinar
          .where('registeredAccount', arrayContains: idUser)
          .where('date',
              isLessThanOrEqualTo: DateFormat.yMd().format(date).toString())
          .snapshots()
          .listen((pastWebinars) {
        historyStarted.value = pastWebinars.docs
            .map((e) => WebinarModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        print("HISTORY STARTED: ${historyStarted.value}");
      });
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
    String description,
    String link,
    Map<String, dynamic> openRecruitment,
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
        "id": "",
        "link": link,
        "open_recruitment": openRecruitment,
        "photoUrl": photoUrl,
        "registeredAccount": [],
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

  /** UPDATE ORGANIZATION */
  Future<void> updateOrganization(
    String id,
    Map<String, dynamic> administrator,
    List<String> division,
    String timestamp,
    List<Map<String, dynamic>> contact,
    String description,
    String link,
    Map<String, dynamic> openRecruitment,
    String photoUrl,
    String title,
  ) async {
    try {
      await dbOrganization.doc(id).update({
        "administrator": administrator,
        "createdAt": timestamp,
        "contact": contact,
        "description": description,
        "division": division,
        "link": link,
        "open_recruitment": openRecruitment,
        "photoUrl": photoUrl,
        "title": title,
        "updatedAt": timestamp,
      });

      print("Data updated");
    } catch (e) {
      print("ERROR UPDATE DATA" + e.toString());
    }
  }

  /** READ ORGANIZATION */
  void readDataUserOrganization() {
    try {
      dbOrganization.snapshots().listen((result) {
        if (result.docs.isEmpty) {
          print("No data found for organizations.");
          contentListOrganizationUser.clear();
          return;
        }

        contentListOrganizationUser.value = result.docs
            .map((e) =>
                OrganizationModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("ERROR READ DATA ORGANIZATION : " + e.toString());
    }
  }

  void readDataOrganization() {
    try {
      dbOrganization
          .where('administrator.uid', isEqualTo: authC.user.value.uid)
          .snapshots()
          .listen((result) {
        if (result.docs.isEmpty) {
          print("No data found for organizations.");
          contentListOrganizationProvider.clear();
          return;
        }

        contentListOrganizationProvider.value = result.docs
            .map((e) =>
                OrganizationModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("ERROR READ DATA ORGANIZATION : " + e.toString());
    }
  }

  /** DELETE ORGANIZATION */
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

  /** REGISTER ORGANIZATION */
  Future<void> registerOrganization(String idOrganization, String uid) async {
    try {
      // Mengecek apakah user sudah terdaftar di webinar
      // if (contentListOrganizationUser
      //     .where((element) => element.id == idOrganization)
      //     .first
      //     .registeredAccount!
      //     .contains(uid)) {
      //   print("User already registered to this organization.");
      //   CustomSnackBar(
      //       "Registered!",
      //       "You are already registered to this organization",
      //       Icons.warning_amber_rounded,
      //       Colors.red);
      // } else {
      await dbOrganization.doc(idOrganization).update({
        "registeredAccount": FieldValue.arrayUnion([
          RegisteredAccount(
                  email: authC.user.value.email,
                  faculty: authC.user.value.faculty,
                  major: authC.user.value.major,
                  name: authC.user.value.name,
                  nim: authC.user.value.nim,
                  phone: authC.user.value.phone,
                  role: authC.user.value.role,
                  uid: authC.user.value.uid,
                  username: authC.user.value.username,
                  photoUrl: authC.user.value.photoUrl)
              .toJson()
        ])
      });

      await dbUser.doc(uid).update({
        "registeredOrganization": FieldValue.arrayUnion([idOrganization])
      });

      CustomSnackBar(
        "Success",
        "You are registered to organization",
        Icons.check,
        Colors.green,
      );
      // }

      readDataOrganization();

      print("Registered to organization");
    } catch (e) {
      print("ERROR REGISTER ORGANIZATION" + e.toString());
    }
  }

  Future<void> readRegisteredAccountOrganization(String id) async {
    try {
      accountImage.clear();
      print("Account image cleared"); // Logging tambahan
      // Mendapatkan dokumen organisasi berdasarkan ID
      DocumentSnapshot docSnapshot = await dbOrganization.doc(id).get();
      print("Document snapshot obtained"); // Logging tambahan

      // Mengecek apakah dokumen tersebut ada
      if (docSnapshot.exists) {
        print("Document exists"); // Logging tambahan
        // Mengambil data dari dokumen
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        print("Data extracted: $data"); // Logging tambahan

        // Mengambil daftar registeredAccount
        List<dynamic> registeredAccounts = data['registeredAccount'];
        print("Registered accounts: $registeredAccounts"); // Logging tambahan

        // Loop melalui daftar registeredAccount untuk mendapatkan photoUrl
        for (var account in registeredAccounts) {
          RegisteredAccount registeredAccount =
              RegisteredAccount.fromJson(account as Map<String, dynamic>);
          print(
              "Registered account created: $registeredAccount"); // Logging tambahan

          accountImage.add(registeredAccount);
          print("Account image updated: $accountImage"); // Logging tambahan

          if (registeredAccount.uid != null &&
              registeredAccount.photoUrl != null) {
            print(
                'UID: ${registeredAccount.uid}, Photo URL: ${registeredAccount.photoUrl}');
          } else {
            print('Missing data for an account: $account');
          }
        }

        // Mengambil foto dari daftar
        for (var account in accountImage) {
          print('Photo URL from list: ${account.photoUrl}');
        }
      } else {
        print("No such document!");
      }
    } catch (e) {
      print("Error reading registered accounts: $e");
    }
  }
}
