import 'package:flutter/material.dart';
import 'package:tzens/app/utils/constant/color.dart';

class Formulir extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;

  const Formulir({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hintText == "Password" ? true : false,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: secondaryColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
    );
  }
}