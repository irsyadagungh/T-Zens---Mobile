import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/utils/constant/webinar_utils.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class WebinarView extends StatelessWidget {
  WebinarView({Key? key}) : super(key: key);

  final contentController = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    contentController.readDataUser();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Webinar dan Seminar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Kumpulan webinar dan seminar yang bisa kamu ikuti ! "),
                ],
              ),
            ),
            Obx(() => Wrap(
                  spacing: 10.0, // Jarak antara item secara horizontal
                  runSpacing: 10.0, // Jarak antara baris secara vertikal
                  children: List.generate(
                    contentController.contentList.length,
                    (index) {
                      WebinarModel content =
                          contentController.contentList[index];
                      print(content.toString() + "dadadada");
                      return CardPotret(
                        model: WebinarModel(
                          title: content.title,
                          photo: content.photo,
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
