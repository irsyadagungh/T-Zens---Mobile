import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: SizedBox(
                        height: 250,
                        width: 390,
                        child: AnotherCarousel(
                          images: [
                            AssetImage("./assets/images/gambar.png"),
                            AssetImage("./assets/images/gambar.png"),
                          ],
                          dotSize: 4.0,
                          dotSpacing: 15.0,
                          dotColor: Colors.lightGreenAccent,
                          indicatorBgPadding: 5.0,
                          dotBgColor: null,
                          borderRadius: true,
                          moveIndicatorFromBottom: 180.0,
                          noRadiusForIndicator: true,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Webinar dan Seminar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Kumpulan webinar dan seminar yang bisa kamu ikuti ! ",
                  ),
                ],
              ),
            ),
            Obx(
              () => GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 9 / 14.5,
                ),
                itemCount: contentController.contentList.length,
                itemBuilder: (context, index) {
                  WebinarModel content = contentController.contentList[index];
                  print(content.toString() + "dadadada");
                  return CardPotret(
                    model: WebinarModel(
                      title: content.title,
                      photo: content.photo,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
