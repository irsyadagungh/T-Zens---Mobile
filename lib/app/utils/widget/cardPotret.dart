import 'package:flutter/material.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';

class CardPotret extends StatelessWidget {
  const CardPotret({
    Key? key,
    required this.title,
    required this.photo,
    required this.date,
    required this.status,
  });

  final String photo;
  final String title;
  final String date;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    "${photo}" // Agar gambar menyesuaikan ruang yang tersedia
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
                        "${title}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // Harusnya Tanggal
                            "${date}",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("${status}",
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
    );
  }
}
