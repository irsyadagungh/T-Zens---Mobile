import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tzens/app/data/models/user_model_model.dart';
import 'package:tzens/app/modules/login/views/login_view.dart';
import 'package:tzens/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isSkipIntro = false.obs;
  RxBool isAuth = false.obs;
  RxBool isSignIn = false.obs;

  UserCredential? userCredential;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
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

  // Observable variables
  var currentUser = Rxn<GoogleSignInAccount>();
  var isAuthorized = false.obs;

  @override
  void onInit() {
    super.onInit();
    // ✅ SETUP EVENT LISTENER
    _googleSignIn.authenticationEvents.listen(_handleAuthEvent);
    firstInitialized();
  }

  // ✅ EVENT HANDLER - Mengganti signInSilently()
  void _handleAuthEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        _currentUser = event.user;
        currentUser.value = event.user;
        isAuth.value = true;
        print("Google User Signed In: ${event.user.displayName}");
        loadUserData();
        break;
        
      case GoogleSignInAuthenticationEventSignOut():
        _currentUser = null;
        currentUser.value = null;
        // Jangan set isAuth = false di sini jika masih ada Firebase auth
        print("Google User Signed Out");
        break;
    }
  }

  // ✅ INITIAL CHECK - Tanpa signInSilently()
  Future<void> firstInitialized() async {
    try {
      print("Checking initial auth status...");
      
      // Cek Firebase Auth
      final firebaseUser = auth.currentUser;
      
      // ❌ TIDAK BISA LAGI: await _googleSignIn.signInSilently();
      // ✅ ALTERNATIF: Cek apakah ada stored session
      
      if (firebaseUser != null) {
        isAuth.value = true;
        await loadUserData();
        print("Firebase user found: ${firebaseUser.email}");
      }
      
      // Google Sign-In status akan otomatis diupdate via event stream
      // jika user sebelumnya sudah login
      
    } catch (e) {
      print('Error in firstInitialized: $e');
    }
    
    // Handle skip intro logic
    if (box.read('skipIntro') == true) {
      isSkipIntro.value = true;
    } else {
      isSkipIntro.value = false;
    }
  }

  // ✅ SIGN IN WITH GOOGLE
  Future<void> signInWithGoogle() async {
    try {
      final user = await _googleSignIn.authenticate();
      if (user != null) {
        // Event akan otomatis dipanggil melalui authenticationEvents stream
        print("Sign in successful: ${user.displayName}");
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
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
        await _googleSignIn.signOut();
        await auth.signOut();
      } else if (_currentUser != null) {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }
      isAuth.value = false;
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }


  // ✅ Manual check
  bool get isGoogleSignedIn => _currentUser != null;
  
  void handleAuthEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        _currentUser = event.user;
        isSignIn.value = true;
        break;
      case GoogleSignInAuthenticationEventSignOut():
        _currentUser = null;
        isSignIn.value = false;
        break;
    }
  }

  /** LOGIN WITH GOOGLE */
  Future<void> login() async {
    try {
      // Mencegah kebocoran data
      await _googleSignIn.signOut();

      // Menampilkan dialog login
      await _googleSignIn.authenticate().then((value) => _currentUser = value);

      // Mengecek apakah user sudah login
      handleAuthEvent(GoogleSignInAuthenticationEventSignIn(user: _currentUser!));

      if (isSignIn.value) {
        print("BERHASIL LOGIN");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.idToken,
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

      user.update(
        (val) {
          val!.email = email;
          val.faculty = faculty;
          val.major = major;
          val.name = fullname;
          val.nim = nim;
          val.phone = phone;
          val.username = username;
          val.photoUrl = photoUrl;
        },
      );

      Get.back();
    } catch (e) {
      print(e);
    }
  }

  /** UPDATE TOKEN FOR FCM */
  Future<void> updateToken(String token) async {
    try {
      await dbUser.doc(user.value.uid).update({
        'token': token,
      });
      user.update((val) {
        val!.token = token;
      });
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
