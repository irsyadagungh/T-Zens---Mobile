import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/detail_page/views/detail_page_view.dart';
import 'package:tzens/app/utils/constant/webinar_utils.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class WebinarView extends StatelessWidget {
  WebinarView({Key? key}) : super(key: key);

  final contentController = Get.find<ContentController>();

  double convertToDp(BuildContext context, double valueInDouble) {
    // Dapatkan faktor skala dari MediaQuery
    double scaleFactor = MediaQuery.of(context).devicePixelRatio;

    // Hitung nilai dalam satuan dp
    double valueInDp = valueInDouble / scaleFactor;

    return valueInDp;
  }

  double calculateAspectRatio(BuildContext context) {
    // Dapatkan faktor skala dari MediaQuery
    double scaleFactor = MediaQuery.of(context).devicePixelRatio;

    // Hitung aspect ratio secara dinamis berdasarkan tinggi item
    double itemHeight =
        convertToDp(context, 100); // Misalnya, tinggi item 100 dp
    return itemHeight /
        (2 * scaleFactor); // Misalnya, bagi dengan 2 untuk aspect ratio 2:1
  }

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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailPageView(model: content);
                          },
                        ),
                      );
                    },
                    child: CardPotret(
                      photo: "${content.photo}",
                      title: "${content.title}",
                      date: "${content.date}",
                      status: "${content.status}",
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
