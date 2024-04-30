import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/detail_sliverAppBar.dart';
import 'package:tzens/app/utils/widget/valueSection.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key, required this.model}) : super(key: key);
  final WebinarModel model;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppbarDetail(
              image: "${model.photo}",
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      Text(
                        "${model.title}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                          child: Row(
                            children: [
                              // Harusnya
                              Text("${model.location}"),
                              const SizedBox(
                                width: 8.0,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Divider(
                        thickness: 1.0,
                      ),
                      DescriptionSection(
                        header: "Deskripsi",
                        desc: "${model.description}",
                      ),
                      DescriptionSection(
                        header: "Benefit",
                        desc: "${model.benefits}",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
