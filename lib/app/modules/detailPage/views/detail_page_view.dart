import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/utils/model/dataModels.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key, required this.model}) : super(key: key);
  final DataModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Subtitle: ${model.subtitle}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${model.status}',
              style: TextStyle(fontSize: 18),
            ),
            Text(model.desc.isEmpty ? "Data tidak ada" : model.desc),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                isDense: true,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Warna bayangan
              spreadRadius: 5, // Menyebar bayangan
              blurRadius: 7, // Blur bayangan
              offset: Offset(0, 3), // Offset bayangan
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: FilledButton(
            onPressed: () {},
            child: Text("Daftar Sekarang"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            )),
          ),
        ),
      ),
    );
  }
}
