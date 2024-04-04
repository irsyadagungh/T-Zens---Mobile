import 'package:flutter/material.dart';
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
      ),
    ),
    CardPotret(
      model: DataModel(
        title: "Seminar Kampus Merdeka",
        subtitle: "Senin, 10 Januari",
        status: "GRATIS",
      ),
    ),
    CardPotret(
      model: DataModel(
        title: "Workshop Design UI/UX",
        subtitle: "Jumat, 30 Desember",
        status: "PAID",
      ),
    ),
    CardPotret(
      model: DataModel(
        title: "Webinar Tips Belajar UI/UX",
        subtitle: "Rabu, 15 Februari",
        status: "GRATIS",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<CardPotret> filteredCards = List.from(cards);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
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
                          "Rekomendasi Untuk Anda",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Kumpulan webinar dan seminar yang kamu minati !"),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          filteredCards.map<Widget>((card) => card).toList(),
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
                        Text(
                            "Kumpulan webinar dan seminar yang bisa kamu ikuti ! "),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Wrap(
                        spacing: 15, // Atur jarak horizontal antara dua card
                        runSpacing:
                            6, // Atur jarak vertikal antara dua baris card
                        children:
                            filteredCards.map<Widget>((card) => card).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
