import 'package:flutter/material.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class RecView extends StatelessWidget {
  RecView({super.key});
  final List<CardPotret> cards = [
    CardPotret(model: WebinarModel(title: "Seminar Kampus Merdeka")),
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
    // CardPotret(
    //   model: DataModel(
    //       title: "Webinar Tips Belajar UI/UX",
    //       subtitle: "Rabu, 15 Februari",
    //       status: "GRATIS",
    //       desc: ""),
    // ),
    // CardPotret(
    //   model: DataModel(
    //       title: "Webinar Tips Belajar UI/UX",
    //       subtitle: "Rabu, 15 Februari",
    //       status: "GRATIS",
    //       desc: ""),
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
    List<CardPotret> filteredCards = List.from(cards);
    return Container(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filteredCards.map<Widget>((card) => card).toList(),
        ),
      ),
    );
  }
}
