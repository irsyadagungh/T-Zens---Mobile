import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/modules/home_provider/views/home_provider_view.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/Form_Widget.dart';
import 'package:tzens/app/utils/widget/dynamic_form_one_field.dart';
import 'package:tzens/app/utils/widget/large_button.dart';

import '../controllers/add_controller.dart';

class AddView extends StatelessWidget {
  AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());
    final auth = Get.find<AuthController>();
    final contentC = Get.put(ContentController());

    return Hero(
      tag: 'add_event',
      child: Scaffold(
        backgroundColor: customWhite,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text('Add Seminar'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: kBottomNavigationBarHeight,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),

                // Upload Image
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Foto
                      Text(
                        'Upload Image',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => controller.imageFile.value == null
                              ? IconButton(
                                  onPressed: () => controller.pickImage(),
                                  icon:
                                      Icon(Icons.add_photo_alternate_outlined),
                                )
                              : Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 300,
                                      child: Image.file(
                                        controller.imageFile.value!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    IconButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.black,
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.dialog(AlertDialog(
                                          title: Text("Remove Image"),
                                          content: Text(
                                              "Are you sure want to remove this image?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                controller.removeImage();
                                                Get.back();
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
                                        ));
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      /* Title */
                      FormText(
                        icon: Icon(Icons.title),
                        hintText: "Title",
                        controller: controller.titleController,
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      FormText(
                        hintText: "Description",
                        controller: controller.descriptionController,
                        minLines: 5,
                        maxLines: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      FormText(
                        icon: Icon(Icons.location_on),
                        hintText: "Location",
                        controller: controller.locationController,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // Benefit
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Benefits",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Obx(
                        () => DynamicFormOneField(
                          icon: Icon(Icons.star_rounded),
                          name: "Benefit",
                          controller: controller,
                          itemCount: controller.totalBenefit.value,
                          nameController: controller.listBenefitController,
                          onPressedTrue: () {
                            controller.listBenefitController
                                .add(TextEditingController());
                            controller.benefitIncrement();
                            controller.update();
                            print(controller.totalBenefit.value);
                          },
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Prasyarat
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prasyarat",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Obx(
                            () => DynamicFormOneField(
                              icon: Icon(Icons.source_rounded),
                              name: "Prasyarat",
                              controller: controller,
                              itemCount: controller.totalPrasyarat.value,
                              nameController:
                                  controller.listPrasyaratController,
                              onPressedTrue: () {
                                controller.listPrasyaratController
                                    .add(TextEditingController());
                                controller.prasyaratIncrement();
                                controller.update();
                                print(controller.totalPrasyarat.value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // Benefit
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Benefits",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Obx(
                        () => DynamicFormTwoField(
                          iconField1: Icon(Icons.contacts_rounded),
                          iconField2: Icon(Icons.phone),
                          controller: controller,
                          itemCount: controller.totalContact.value,
                          textEditingController1:
                              controller.listContactNameController,
                          textEditingController2:
                              controller.listContactPhoneController,
                          increment: controller.contactIncrement,
                          decrement: controller.contactDecrement,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: LargeButton(
            text: "Confirm",
            onPressed: () async {
              // await contentC.setCollection(Get.currentRoute);

              List<Map<String, dynamic>> addContact() {
                List<Map<String, dynamic>> contact = [];
                int i = 0;
                while (i < controller.totalContact.value) {
                  contact.add({
                    "name": controller.listContactNameController[i].text,
                    "phone": controller.listContactPhoneController[i].text
                  });
                  i++;
                }
                return contact;
              }

              print(auth.user.toJson());
              try {
                await contentC.uploadImage(File(controller.pickedFile!.path),
                    controller.pickedFile!.name);

                print(controller.pickedFile!.path);
                print(controller.pickedFile!.name);

                contentC.addData(
                  controller.listBenefitController.map((e) => e.text).toList(),
                  controller.date.text,
                  controller.descriptionController.text,
                  addContact(),
                  auth.user.toJson(),
                  contentC.picLink.value,
                  controller.listPrasyaratController
                      .map((e) => e.text)
                      .toList(),
                  controller.status.text,
                  controller.titleController.text,
                  controller.locationController.text,
                  DateTime.now().toString(),
                );

                Get.dialog(AlertDialog(
                  title: Text("Success"),
                  content: Column(
                    children: [
                      Text(contentC.picLink.value),
                      Text(controller.pickedFile!.path),
                      Text(controller.titleController.text),
                      Text("Data added successfully"),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.to(() => HomeProviderView());
                      },
                      child: Text("OK"),
                    ),
                  ],
                ));

                Get.snackbar("Success", "Data added successfully",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white);

                // Get.to(() => HomeProviderView());
              } catch (e) {
                print("ERROR DISINI" + e.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}

class DynamicFormTwoField extends StatelessWidget {
  const DynamicFormTwoField({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.textEditingController1,
    required this.textEditingController2,
    required this.increment,
    required this.decrement,
    required this.iconField1,
    required this.iconField2,
  });

  final AddController controller;
  final int itemCount;
  final List<TextEditingController> textEditingController1;
  final List<TextEditingController> textEditingController2;
  final Function() increment;
  final Function() decrement;
  final Icon iconField1;
  final Icon iconField2;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (ctx, index) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: FormText(
                    icon: iconField1,
                    hintText: "Contact Name",
                    controller: textEditingController1[index],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FormText(
                    icon: iconField2,
                    hintText: "Contact Phone",
                    controller: textEditingController2[index],
                  ),
                ),
                index < 1
                    ? IconButton(
                        color: Colors.black,
                        onPressed: () {
                          textEditingController1.add(TextEditingController());
                          textEditingController2.add(TextEditingController());
                          increment();
                          controller.update();
                          print(controller.totalContact.value);
                        },
                        icon: Icon(Icons.add),
                      )
                    : IconButton(
                        color: Colors.red,
                        onPressed: () {
                          textEditingController1[index].clear();
                          textEditingController2[index].clear();
                          textEditingController1[index].dispose();
                          textEditingController2[index].dispose();
                          textEditingController1.removeAt(index);
                          textEditingController2.removeAt(index);
                          decrement();
                          controller.update();
                          print(controller.totalContact.value);
                        },
                        icon: Icon(Icons.delete),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
