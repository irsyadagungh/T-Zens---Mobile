import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tzens/app/data/models/user_model_model.dart';
import 'package:tzens/app/modules/login/views/login_view.dart';
import 'package:tzens/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isSkipIntro = false.obs;
  UserCredential? userCredential;
  CollectionReference db = FirebaseFirestore.instance.collection('users');
  UserModel user = UserModel();

  RxString role = "".obs;

  // final _isLogedIn = false.obs;

  // Register with email and password
  Future<void> signUpWithEmailAndPassword(
      fullname, username, email, password, role) async {
    // Action when button pressed
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final checkUser = await db.doc(userCredential!.user!.uid).get();
      final userId = userCredential!.user!.uid;

      if (checkUser.exists) {
        Get.to(() => LoginView());
        Get.snackbar("Account", "Your account already exists");
      } else {
        await db.doc(userId).set({
          'email': email,
          'faculty': "",
          'major': "",
          'name': fullname,
          'nim': "",
          'phone': "",
          'role': role,
          'uid': userCredential!.user!.uid,
          'username': username,
          'photoUrl': "",
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // Login with email and password
  Future<void> signInWithEmailAndPassword(email, password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final currUser = await db.doc(userCredential!.user!.uid).get();

      user = UserModel(
        email: currUser['email'],
        faculty: currUser['faculty'],
        major: currUser['major'],
        name: currUser['name'],
        nim: currUser['nim'],
        phone: currUser['phone'],
        role: currUser['role'],
        uid: currUser['uid'],
        username: currUser['username'],
        photoUrl: currUser['photoUrl'],
      );

      print(user.name);

      if (user.role == "student") {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.HOME_PROVIDER);
      }
    } catch (e) {
      print(e);
    }
  }
}
