import 'package:flutter/material.dart';
import 'package:tzens/app/utils/constant/color.dart';

class FormText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final Icon icon;
  final String? helperText;
  final Function()? onTap;
  final Function(String)? onChange;
  final bool enabled;
  final TextInputType? keyboardType;

  const FormText({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChange,
    this.keyboardType,
    this.enabled = true,
    this.onTap,
    this.helperText,
    this.minLines = 1,
    this.maxLines = 1,
    this.icon = const Icon(Icons.person, color: primaryColor),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      onChanged: onChange,
      onTap: onTap,
      obscureText: hintText == "Password" ? true : false,
      decoration: InputDecoration(
        helperText: hintText == "Location" ? helperText : null,
        prefixIconColor: primaryColor.withOpacity(0.8),
        prefixIcon: icon,
        focusColor: primaryColor,
        hintText: hintText,
        filled: true,
        fillColor: primaryColor.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
    );
  }
}
