import 'package:flutter/material.dart';

class IntroductionModel {
  final Color bgColor;
  final String lottie;
  final String title;
  final String subtitle;
  final Widget button;

  IntroductionModel(
      {required this.bgColor,
      required this.lottie,
      required this.title,
      required this.subtitle,
      required this.button});
}
