import 'package:flutter/material.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/model/descriptionModels.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection(
      {super.key, required this.desc, required this.header});
  final String desc;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            desc,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Divider(
            thickness: 1.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
