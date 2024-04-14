import 'package:flutter/material.dart';

class SliverAppbarDetail extends StatelessWidget {
  const SliverAppbarDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 375.0,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/gambar.png',
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
            decoration: BoxDecoration(color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}
