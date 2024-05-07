import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/utils/constant/color.dart';

class SliverAppbarDetail extends StatelessWidget {
  final String image;
  final String title;
  const SliverAppbarDetail(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      leading: IconButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(customWhite.withOpacity(0.5)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      expandedHeight: 500.0,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: () => Get.dialog(
            AlertDialog(
              content: Image.network(image),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          height: 25.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: customWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
        ),
      ),
    );
  }
}
