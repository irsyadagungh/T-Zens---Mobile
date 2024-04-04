import 'package:flutter/material.dart';
import 'package:tzens/app/modules/detailPage/views/detail_page_view.dart';
import 'package:tzens/app/utils/model/dataModels.dart';

class CardPotret extends StatelessWidget {
  const CardPotret({Key? key, required this.model});
  final DataModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPageView(
              model: DataModel(
                  title: model.title,
                  subtitle: model.subtitle,
                  status: model.status),
            ),
          ),
        );
      },
      child: Container(
        height: 290,
        width: 190,
        margin: EdgeInsets.only(right: 0),
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
                  child: Image.asset("assets/images/gambar.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          model.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.subtitle,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(model.status,
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
