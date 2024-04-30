import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tzens/app/utils/screen/webinar_Screen.dart';

class SliverAppbarDetail extends StatelessWidget {
  const SliverAppbarDetail({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 375.0,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          image,
          fit: BoxFit.cover,
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          height: 32.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0))),
          child: Container(
            width: 45.0,
            height: 5.0,
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 255, 18, 18)),
          ),
        ),
      ),
      leadingWidth: 80.0,
      leading: Container(
        margin: const EdgeInsets.only(left: 24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(56.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
              ),
              child: Container(
                height: 56.0,
                width: 56.0,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/arrow-ios-back-outline.svg',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
