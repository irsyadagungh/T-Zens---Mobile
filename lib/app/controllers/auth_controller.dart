import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/user_model_model.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/login/views/login_view.dart';
import 'package:tzens/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isSkipIntro = false.obs;
  RxBool isAuth = false.obs;

  UserCredential? userCredential;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  CollectionReference dbUser = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  Rx<UserModel> user = UserModel().obs;

  RxString role = "".obs;
  RxBool bookmarked = false.obs;
  final box = GetStorage();

  // final _isLogedIn = false.obs;

  late Reference storage = FirebaseStorage.instance.ref();
  RxString picLink = "".obs;

  @override
  void onInit() {
    super.onInit();
    firstInitialized();
  }

  Future<void> firstInitialized() async {
    try {
      print("IS AUTH NYA ADALAH = " + isAuth.value.toString());
      print("AKUN YANG LOGIN = " + auth.currentUser.toString());
      print("AKUN GOOGLE YANG LOGIN = " + _googleSignIn.currentUser.toString());
      final isSignInGoogle = await _googleSignIn.isSignedIn();
      final isSignInEmail = auth.currentUser;

      if (isSignInGoogle || isSignInEmail != null) {
        isAuth.value = true;
        if (isSignInGoogle) {
          _currentUser = await _googleSignIn.signInSilently();
        }
        await loadUserData();
      }
    } catch (e) {
      print(e);
    }
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      isSkipIntro.value = box.read('skipIntro');
    } else {
      isSkipIntro.value = false;
    }
  }

  Future<void> loadUserData() async {
    try {
      if (auth.currentUser != null) {
        final currUser = await dbUser.doc(auth.currentUser!.uid).get();
        user.value = UserModel(
          bookmark: currUser['bookmark'],
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
        print(user.value.name);
      }
    } catch (e) {
      print(e);
    }
  }

  /** REGISTER WITH EMAIL */
  Future<void> signUpWithEmailAndPassword(String fullname, String username,
      String email, String password, String role) async {
    try {
      // Attempt to create the user with email and password
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userId = userCredential!.user!.uid;
      final userToken = await userCredential!.user!.getIdToken();

      print("USER TOKEN = ${userToken}");

      // Check if the user already exists in Firestore
      final checkUser = await dbUser.doc(userId).get();

      if (checkUser.exists) {
        // If user exists, navigate to LoginView and show snackbar
        Get.to(() => LoginView());
        Get.snackbar("Account", "Your account already exists");
      } else {
        // If user does not exist, create the user document in Firestore
        await dbUser.doc(userId).set({
          'bookmark': [],
          'email': email,
          'faculty': "",
          'major': "",
          'name': fullname,
          'nim': "",
          'phone': "",
          'registeredWebinar': [],
          'role': role,
          'uid': userId,
          'username': username,
          'photoUrl': "",
          'token': userToken,
        });
      }
    } catch (e) {
      // Handle errors, such as email already in use
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          print("The email address is already in use by another account.");
          Get.snackbar("Error",
              "The email address is already in use by another account.");
        } else {
          print("Error: ${e.message}");
          Get.snackbar("Error", e.message ?? "An error occurred");
        }
      } else {
        print("Error: $e");
        Get.snackbar("Error", e.toString());
      }
    }
  }

  /** LOGIN WITH EMAIL */
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in with email and password
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await loadUserData();

      // Load current user data from Firestore
      final currUser = await dbUser.doc(userCredential!.user!.uid).get();

      // Update user model with the retrieved data
      user.value = UserModel(
        bookmark: currUser['bookmark'],
        email: currUser['email'],
        faculty: currUser['faculty'],
        major: currUser['major'],
        name: currUser['name'],
        nim: currUser['nim'],
        phone: currUser['phone'],
        registeredWebinar: currUser['registeredWebinar'],
        role: currUser['role'],
        uid: currUser['uid'],
        username: currUser['username'],
        photoUrl: currUser['photoUrl'],
        token: currUser['token'],
      );

      // Print user name for debugging
      print(user.value.name);

      // Write 'skipIntro' flag to local storage
      box.write('skipIntro', true);

      // Navigate to the appropriate home screen based on user role
      if (user.value.role == "student") {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.HOME_PROVIDER);
      }
    } catch (e) {
      // Handle errors during sign-in
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  /** LOGOUT */
  Future<void> signOut() async {
    try {
      if (auth.currentUser != null) {
        await auth.signOut();
      } else if (_googleSignIn.currentUser != null) {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }
      isAuth.value = false;
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }

  /** LOGIN WITH GOOGLE */
  Future<void> login() async {
    try {
      // Mencegah kebocoran data
      await _googleSignIn.signOut();

      // Menampilkan dialog login
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      // Mengecek apakah user sudah login
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        print("BERHASIL LOGIN");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await auth
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        final checkUser = await dbUser.doc(userCredential!.user!.uid).get();

        if (checkUser.exists) {
          await loadUserData();
          Get.toNamed(Routes.HOME);
        } else {
          await dbUser.doc(userCredential!.user!.uid).set({
            'bookmark': [],
            'email': userCredential!.user!.email,
            'faculty': "",
            'major': "",
            'name': userCredential!.user!.displayName,
            'nim': "",
            'phone': "",
            'registeredWebinar': [],
            'role': role.value,
            'token': credential.accessToken,
            'uid': userCredential!.user!.uid,
            'username': userCredential!.user!.displayName,
            'photoUrl': userCredential!.user!.photoURL,
          });
          await loadUserData();
          Get.toNamed(Routes.HOME);
        }

        dbUser.doc(userCredential!.user!.uid).get().then((value) {
          user.value = UserModel(
            bookmark: value['bookmark'],
            email: value['email'],
            faculty: value['faculty'],
            major: value['major'],
            name: value['name'],
            nim: value['nim'],
            phone: value['phone'],
            registeredWebinar: value['registeredWebinar'],
            role: value['role'],
            uid: value['uid'],
            username: value['username'],
            photoUrl: value['photoUrl'],
          );
        });
        print("USER CREDENTIAL = " + userCredential.toString());
      } else {
        print("GAGAL LOGIN");
      }

      isAuth.value = true;
      box.write('skipIntro', true);
      Get.toNamed(Routes.HOME);
    } catch (e) {
      print(e);
    }
  }

  /** EDIT PROFILE */
  Future<void> editProfile(
    String fullname,
    String username,
    String email,
    String nim,
    String faculty,
    String major,
    String phone,
    String photoUrl,
  ) async {
    try {
      await dbUser.doc(user.value.uid).update({
        'email': email,
        'faculty': faculty,
        'major': major,
        'name': fullname,
        'nim': nim,
        'phone': phone,
        'username': username,
        'photoUrl': photoUrl
      });

      user.value = UserModel(
        email: email,
        faculty: faculty,
        major: major,
        name: fullname,
        nim: nim,
        phone: phone,
        role: user.value.role,
        uid: user.value.uid,
        username: username,
        photoUrl: user.value.photoUrl,
      );

      Get.back();
    } catch (e) {
      print(e);
    }
  }

  /** UPLOAD IMAGE */
  Future<void> uploadImage(File imageFile, String name) async {
    try {
      final path = "user/${name}";
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

  /** ADD BOOKMARK WEBINAR */
  Future<void> bookmarkWebinar(String id) async {
    try {
      //cek apakah webinar sudah di bookmark
      if (user.value.bookmark!.contains(id)) {
        user.value.bookmark!.remove(id);
        await dbUser.doc(user.value.uid).update({
          'bookmark': user.value.bookmark,
        });
        bookmarked.value = false;
        print("WEBINAR DIHAPUS DARI BOOKMARK, DENGAN ID = ${id}");
        user.update((val) {
          val!.bookmark!.remove(id);
        });
      } else {
        if (user.value.bookmark == null || user.value.bookmark == [""]) {
          user.value.bookmark!.add(id);
          await dbUser.doc(user.value.uid).set({
            'bookmark': user.value.bookmark,
          });
          bookmarked.value = true;
        } else {
          user.value.bookmark!.add(id);
          await dbUser.doc(user.value.uid).update({
            'bookmark': user.value.bookmark,
          });
        }

        print("WEBINAR DITAMBAHKAN KE BOOKMARK, DENGAN ID = ${id}");
        user.update((val) {
          val!.bookmark!.add(id);
        });
      }
    } catch (e) {
      print("ERROR ADD BOOKMARK WEBINAR : $e");
    }
  }
}
