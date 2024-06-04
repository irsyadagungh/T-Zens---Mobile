import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/modules/detailPageOrganisasi/views/detail_page_organisasi_view.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class OrganisasiView extends StatelessWidget {
  OrganisasiView({super.key});

  final contentController = Get.find<ContentController>();

  final List<CardPotret> cards = [
    // CardPotret(
    //   model: DataModel(
    //       title: "Webinar Tips Belajar Coding HTML",
    //       subtitle: "Minggu, 27 Januari",
    //       status: "GRATIS",
    //       desc:
    //           "Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information."),
    // ),
    // CardPotret(
    //   model: DataModel(
    //       title: "Seminar Kampus Merdeka",
    //       subtitle: "Senin, 10 Januari",
    //       status: "GRATIS",
    //       desc:
    //           "Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information."),
    // ),
    // CardPotret(
    //   model: DataModel(
    //       title: "Workshop Design UI/UX",
    //       subtitle: "Jumat, 30 Desember",
    //       status: "PAID",
    //       desc:
    //           "Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information."),
    // ),
    // CardPotret(
    //   model: DataModel(
    //       title: "Webinar Tips Belajar UI/UX",
    //       subtitle: "Rabu, 15 Februari",
    //       status: "GRATIS",
    //       desc: ""),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    contentController.readDataUserOrganization();
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
                    "Organisasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Kumpulan Organisasi yang bisa kamu ikuti ! "),
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
                  childAspectRatio: 0.601,
                ),
                itemCount:
                    contentController.contentListOrganizationProvider.length,
                itemBuilder: (context, index) {
                  OrganizationModel content =
                      contentController.contentListOrganizationProvider[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailPageOrganisasiView(model: content));
                    },
                    child: CardPotret(
                      photo: "${content.photoUrl}",
                      title: "${content.title}",
                      date: "",
                      status: "",
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
