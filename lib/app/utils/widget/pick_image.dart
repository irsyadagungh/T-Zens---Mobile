import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/utils/constant/color.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    super.key,
    required this.controller,
    required this.height,
    required this.width,
    required this.radius,
    required this.image,
    required this.pickImageButton,
    this.isEdit = true,
  });

  final controller;
  final double height;
  final double width;
  final double radius;
  final bool isEdit;
  final Widget image;
  final Widget pickImageButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        color: !isEdit ? Colors.grey.withOpacity(0.8) : Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAlias,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Obx(
        () => controller.imageFile.value == null
            ? pickImageButton
            : Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 200,
                    height: 300,
                    child: image,
                  ),
                  IconButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white.withOpacity(0.5),
                      ),
                    ),
                    onPressed: () {
                      Get.dialog(AlertDialog(
                        title: Text("Remove Image"),
                        content:
                            Text("Are you sure want to remove this image?"),
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
    );
  }
}
