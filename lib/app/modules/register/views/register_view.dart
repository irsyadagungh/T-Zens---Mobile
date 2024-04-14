import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/login/views/login_view.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/Form_Widget.dart';
import 'package:tzens/app/utils/widget/google_button.dart';
import 'package:tzens/app/utils/widget/large_button.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final controller = Get.put(RegisterController());

    final TextEditingController _fullNameController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    print(auth.role.value);

    return Scaffold(
      backgroundColor: customWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),

                    // Fullname
                    Formulir(
                      hintText: "Fullname",
                      controller: _fullNameController,
                    ),

                    // Username
                    Formulir(
                      hintText: "Username",
                      controller: _usernameController,
                    ),

                    // Email
                    Formulir(
                      hintText: "Email",
                      controller: _emailController,
                    ),

                    // Password
                    Formulir(
                      hintText: "Password",
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50,
              ),

              // Button
              LargeButton(
                text: "Register",
                onPressed: () async {
                  try {
                    await auth.signUpWithEmailAndPassword(
                        _fullNameController.text,
                        _usernameController.text,
                        _emailController.text,
                        _passwordController.text,
                        auth.role.value);

                    Get.to(() => LoginView());
                    controller.showPopupDialog();
                  } catch (e) {}

                  Get.to(() => LoginView());
                },
              ),

              SizedBox(
                height: 20,
              ),

              // Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text("Login"),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              // or login with google
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or continue with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              // Google Button
              GoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
