import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/detailPage/views/detail_page_view.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

import '../controllers/bookmark_user_controller.dart';

class BookmarkUserView extends GetView<BookmarkUserController> {
  BookmarkUserView({Key? key}) : super(key: key);
  final contentController = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    contentController.readDataUser();

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Bookmark'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Webinar / Seminar",
              ),
              Tab(
                text: "Organisasi",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
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
                      itemCount: contentController.contentListUser.length,
                      itemBuilder: (context, index) {
                        WebinarModel content =
                            contentController.contentListUser[index];
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
                            photo: "${content.photoUrl}",
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
            Center(
              child: Text("It's cloudy here"),
            ),
          ],
        ),
      ),
    );
  }
}
