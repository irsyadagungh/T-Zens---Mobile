import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/utils/widget/Form_Widget.dart';
import 'package:tzens/app/utils/widget/google_button.dart';
import 'package:tzens/app/utils/widget/large_button.dart';
import 'package:tzens/app/utils/widget/medium_button.dart';
import 'package:tzens/app/utils/widget/medium_outlined_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final auth = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),

                  // Email
                  FormText(
                    hintText: "Email",
                    controller: _emailController,
                  ),

                  // Password
                  FormText(
                    hintText: "Password",
                    controller: _passwordController,
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?"),
                ),
              ],
            ),

            SizedBox(
              height: 50,
            ),

            // Button
            LargeButton(
              text: "Login",
              onPressed: () {
                auth.signInWithEmailAndPassword(
                    _emailController.text, _passwordController.text);
              },
            ),

            SizedBox(
              height: 20,
            ),

            // Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Choose your role",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MediumButton(
                            onPressed: () {
                              auth.role.value = "student";
                              Get.back();
                              Get.toNamed("/register");
                            },
                            text: "Student",
                          ),
                          MediumOutlinedButton(
                            onPressed: () {
                              auth.role.value = "lecturer";
                              Get.back();
                              Get.toNamed("/register");
                            },
                          ),
                        ],
                      ),
                    );
                    print(auth.role.value);
                  },
                  child: Text("Sign Up"),
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
    ));
  }
}
