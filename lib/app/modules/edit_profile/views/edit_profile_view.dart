import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/Form_Widget.dart';
import 'package:tzens/app/utils/widget/large_button.dart';
import 'package:tzens/app/utils/widget/large_outlined_button.dart';
import 'package:tzens/app/utils/widget/pick_image.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);

  final authC = Get.find<AuthController>();
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    print("LINK FOTONYA = ${authC.user.value.photoUrl}");
    return Scaffold(
        appBar: AppBar(
          title: Text(Routes.getTitleFromRoute(Get.currentRoute)),
          centerTitle: true,
          actions: [
            Obx(() => controller.isEdit.value == false
                ? IconButton(
                    onPressed: () {
                      controller.isEdit.value = true;
                    },
                    icon: Icon(Icons.edit),
                  )
                : SizedBox())
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /** PHOTO */
                  Center(
                    child: Obx(() => Stack(
                          children: [
                            PickImage(
                              controller: controller,
                              height: 200,
                              width: 200,
                              radius: 100,
                              isEdit: controller.isEdit.value,
                              pickImageButton: authC.user.value.photoUrl != ""
                                  ? Image.network(
                                      "${authC.user.value.photoUrl}",
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        controller.pickImage();
                                      },
                                      icon: Icon(Icons.add_a_photo),
                                    ),
                              image: controller.authC.user.value.photoUrl !=
                                          "" &&
                                      controller.imageFile.value == null
                                  ? Image.network(
                                      "${controller.authC.user.value.photoUrl}",
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : controller.imageFile.value != null &&
                                          controller.imageFile.value!.path != ""
                                      ? Image.file(
                                          controller.imageFile.value!,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.person,
                                          size: 200,
                                        ),
                            ),
                            controller.isEdit.value == true &&
                                    controller.authC.user.value.photoUrl != ""
                                ? Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.pickImage();
                                      },
                                      icon: Icon(Icons.add_a_photo),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        )),
                  ),
                  SizedBox(height: 20),

                  /** EMAIL */
                  Obx(() => FormText(
                        hintText: "Email",
                        controller: controller.emailController,
                        enabled: controller.isEdit.value,
                        icon: Icon(Icons.mail),
                      )),

                  /** PASSWORD */
                  TextButton(
                    onPressed: () {},
                    child: Text("Reset password?"),
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                  ),
                  SizedBox(height: 20),

                  /** NAME */
                  Obx(() => FormText(
                        hintText: "Name",
                        controller: controller.nameController,
                        enabled: controller.isEdit.value,
                        icon: Icon(Icons.assignment_ind_rounded),
                      )),
                  SizedBox(height: 20),

                  /** USERNAME */
                  Obx(() => FormText(
                        hintText: "Username",
                        controller: controller.usernameController,
                        enabled: controller.isEdit.value,
                      )),
                  SizedBox(height: 20),

                  /** NIM */
                  authC.user.value.role == "student"
                      ? Column(
                          children: [
                            Obx(() => FormText(
                                  hintText: "NIM",
                                  controller: controller.nimController,
                                  enabled: controller.isEdit.value,
                                  icon: Icon(Icons.numbers),
                                )),
                            SizedBox(height: 20),

                            /** FACULTY */
                            Obx(() => TextFieldDropDown(
                                  controller: controller.facultyController,
                                  hintText: "Faculty",
                                  list: controller.facultyList,
                                  itemCount: controller.facultyList.length - 1,
                                  onChanged: (val) {
                                    controller.onFacultyChange(controller
                                        .facultyController.dropDownValue);
                                  },
                                  isEnabled: controller.isEdit.value,
                                )),
                            SizedBox(height: 20),

                            /** MAJOR */
                            Obx(
                              () => TextFieldDropDown(
                                controller: controller.majorController,
                                hintText: "Major",
                                list: controller.majorList,
                                itemCount: controller.majorList.length - 1,
                                onChanged: (val) {
                                  print(controller
                                      .majorController.dropDownValue?.name);
                                },
                                isEnabled: controller.isEdit.value == true &&
                                        controller.facultyController
                                                .dropDownValue !=
                                            null
                                    ? true
                                    : false,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : SizedBox(),

                  /** PHONE */
                  Obx(() => FormText(
                        hintText: "Phone",
                        controller: controller.phoneController,
                        enabled: controller.isEdit.value,
                        icon: Icon(Icons.phone),
                      )),
                  SizedBox(height: 20),

                  /** BUTTON */
                  Obx(() {
                    return controller.isEdit.value == false
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: LargeOutlinedButton(
                                  onPressed: () {
                                    controller.isEdit.value = false;
                                  },
                                  text: "Cancel",
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: LargeButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text("Confirmation"),
                                        content: Text(
                                            "Are you sure you want to save the changes?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("No"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              controller.pickedFile != null
                                                  ? await authC.uploadImage(
                                                      File(controller
                                                          .pickedFile!.path),
                                                      controller
                                                          .pickedFile!.name)
                                                  : print("No image selected");
                                              print(
                                                  "LINK = ${authC.picLink.value}");

                                              authC.editProfile(
                                                controller.nameController.text,
                                                controller
                                                    .usernameController.text,
                                                controller.emailController.text,
                                                controller.nimController.text,
                                                controller.facultyController
                                                        .dropDownValue!.name ??
                                                    "",
                                                controller.majorController
                                                        .dropDownValue!.name ??
                                                    "",
                                                controller.phoneController.text,
                                                authC.picLink != ""
                                                    ? authC.picLink.value
                                                    : "",
                                              );
                                              controller.isEdit.value = false;
                                              controller.onInit();
                                            },
                                            child: Text("Yes"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  text: "Save",
                                ),
                              ),
                            ],
                          );
                  })
                ],
              ),
            ),
          ),
        ));
  }
}

class TextFieldDropDown extends StatelessWidget {
  const TextFieldDropDown({
    super.key,
    required this.controller,
    required this.hintText,
    required this.list,
    required this.onChanged,
    required this.itemCount,
    this.isEnabled = true,
  });

  final SingleValueDropDownController controller;
  final String hintText;
  final List<DropDownValueModel> list;
  final bool isEnabled;
  final void Function(dynamic) onChanged;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      dropDownItemCount: itemCount,
      controller: controller,
      dropDownList: list,
      isEnabled: isEnabled,
      onChanged: onChanged,
      textFieldDecoration: InputDecoration(
        label: Text(hintText),
        fillColor: primaryColor.withOpacity(0.2),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        isDense: true,
      ),
    );
  }
}
