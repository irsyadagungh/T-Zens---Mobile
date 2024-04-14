import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tzens/app/utils/constant/color.dart';

import '../controllers/add_controller.dart';

class AddView extends StatelessWidget {
  AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());

    return Hero(
        tag: 'add_event',
        child: Scaffold(
          backgroundColor: customWhite,
          appBar: AppBar(
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
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
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(color: Colors.grey),
                              child: Obx(() {
                                if (controller.imageFile.value == null) {
                                  return Icon(Icons.picture_as_pdf_rounded);
                                } else {
                                  return Image.file(
                                    controller.imageFile.value!,
                                    fit: BoxFit.cover,
                                  );
                                }
                              }),
                            ),
                            FilledButton(
                              onPressed: () {
                                controller.pickImage();
                                controller.update();
                              },
                              child: Text("Upload Image"),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Title
                        TextFormField(
                          decoration: InputDecoration(
                            isDense: true,
                            label: Text("Title"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            isDense: true,
                            label: Text("Description"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: primaryColor,
                              ),
                            ),
                          ),
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
                    child: Obx(
                      () => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.totalBenefit.value,
                        itemBuilder: (ctx, index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          controller.listController[index],
                                      decoration: InputDecoration(
                                        hintText: "Benefit",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  index < 1
                                      ? IconButton(
                                          color: Colors.black,
                                          onPressed: () {
                                            controller.listController
                                                .add(TextEditingController());
                                            controller.increment();
                                            controller.update();
                                            print(
                                                controller.totalBenefit.value);
                                          },
                                          icon: Icon(Icons.add),
                                        )
                                      : IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            controller.listController[index]
                                                .clear();
                                            controller.listController[index]
                                                .dispose();
                                            controller.listController
                                                .removeAt(index);
                                            controller.decrement();
                                            controller.update();
                                            print(
                                                controller.totalBenefit.value);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.benefits.clear();
                      controller.listController.forEach((ctrl) {
                        controller.benefits.add(ctrl.text);
                      });
                      print(controller.benefits);
                    },
                    child: Text("Submit"),
                  ),
                  Text(controller.benefits.toString())
                ],
              ),
            ),
          ),
        ));
  }
}
