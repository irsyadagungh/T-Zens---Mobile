import 'package:flutter/material.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/detailPage/views/detail_page_view.dart';
import 'package:tzens/app/utils/model/dataModels.dart';

class CardPotret extends StatelessWidget {
  const CardPotret({Key? key, required this.model});
  final WebinarModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPageView(
                model: WebinarModel(
                    title: model.title,
                    description: model.description,
                    benefits: model.benefits,
                    contact: model.contact,
                    location: model.location,
                    photo: model.photo,
                    status: model.status,
                    date: model.date)),
          ),
        );
      },
      child: Container(
        // height: 550,
        width: 190,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      width: 250,
                      height: 200,
                      fit: BoxFit.cover,
                      "${model.photo}" // Agar gambar menyesuaikan ruang yang tersedia
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          // Judul
                          "${model.title}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // Harusnya Tanggal
                              "${model.date}",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text("${model.status}",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                          ],
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
