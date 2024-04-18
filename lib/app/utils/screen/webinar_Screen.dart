import 'package:flutter/material.dart';
import 'package:tzens/app/utils/constant/webinar_utils.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class WebinarView extends StatelessWidget {
  WebinarView({super.key});

  final List<CardPotret> cards = [
    CardPotret(
      model: DataModel(
          title: "Webinar Tips Belajar Coding HTML",
          subtitle: "Minggu, 27 Januari",
          status: "GRATIS",
          desc:
              "Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click "),
    ),
    CardPotret(
      model: DataModel(
          title: "Seminar Kampus Merdeka",
          subtitle: "Senin, 10 Januari",
          status: "GRATIS",
          desc:
              "Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information."),
    ),
    CardPotret(
      model: DataModel(
          title: "Workshop Design UI/UX",
          subtitle: "Jumat, 30 Desember",
          status: "PAID",
          desc:
              "Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information. Signing up for seminars or organizations with just one click without needing to provide any personal information."),
    ),
    CardPotret(
      model: DataModel(
          title: "Webinar Tips Belajar UI/UX",
          subtitle: "Rabu, 15 Februari",
          status: "GRATIS",
          desc: ""),
    ),
    CardPotret(
      model: DataModel(
          title: "Webinar Tips Belajar UI/UX",
          subtitle: "Rabu, 15 Februari",
          status: "GRATIS",
          desc: ""),
    ),
    CardPotret(
      model: DataModel(
          title: "Webinar Tips Belajar UI/UX",
          subtitle: "Rabu, 15 Februari",
          status: "GRATIS",
          desc: ""),
    ),
    CardPotret(
      model: DataModel(
          title: "Webinar Tips Belajar UI/UX",
          subtitle: "Rabu, 15 Februari",
          status: "GRATIS",
          desc: ""),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<CardPotret> filteredCards = List.from(cards);
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
                  Text(
                    rekomendasi,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(header),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filteredCards.map<Widget>((card) => card).toList(),
              ),
            ),
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Wrap(
                  spacing: 0, // Atur jarak horizontal antara dua card
                  runSpacing: 6, // Atur jarak vertikal antara dua baris card
                  children: filteredCards.map<Widget>((card) => card).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}