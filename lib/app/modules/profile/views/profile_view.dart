import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:tzens/app/modules/home_provider/bindings/home_provider_binding.dart';
import 'package:tzens/app/modules/home_provider/controllers/home_provider_controller.dart';
import 'package:tzens/app/modules/home_provider/views/home_provider_view.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/function/SnackBar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final homeProviderC = Get.put(HomeProviderController());
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = authC.user;

    print(Get.currentRoute);
    return Scaffold(
        appBar: AppBar(
          title: Text(Routes.getTitleFromRoute(Get.currentRoute)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              /** PROFILE */
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /** PHOTO */
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          clipBehavior: Clip.antiAlias,
                          child: user.value.photoUrl != ""
                              ? Image.network(
                                  "${user.value.photoUrl}",
                                  width: 50,
                                  height: 50,
                                )
                              : Container(
                                  color: Colors.green,
                                  width: 60,
                                  height: 60,
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                  ),
                                ),
                        ),

                        /** NAME */
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.value.name}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("${user.value.email}"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /** ICON */
                    IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Get.toNamed(Routes.EDIT_PROFILE);
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(),

              /** BOOKMARK */
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.BOOKMARK);
                },
                leading: Icon(Icons.bookmark),
                title: Text("Bookmark"),
              ),

              /** HISTORY */
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History"),
              ),

              /** LOGOUT */
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            authC.signOut();
                            CustomSnackBar(
                              "Logout",
                              "You are logged out",
                              Icons.logout,
                              Colors.green,
                            );
                          },
                          child: Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("No"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
