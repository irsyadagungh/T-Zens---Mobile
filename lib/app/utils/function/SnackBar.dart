import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController CustomSnackBar(title, message, icon, iconColor) {
  return Get.snackbar(
    title,
    message,
    icon: Icon(
      icon,
      color: iconColor,
    ),
    overlayBlur: 0.5,
    overlayColor: Colors.black.withOpacity(0.5),
    animationDuration: Duration(milliseconds: 500),
    duration: Duration(seconds: 2),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}
