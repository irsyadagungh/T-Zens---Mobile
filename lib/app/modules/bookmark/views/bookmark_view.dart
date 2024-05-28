import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/modules/detail_page/views/detail_page_view.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  BookmarkView({Key? key}) : super(key: key);
  final contentController = Get.find<ContentController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    print(authC.user.value.bookmark!.length);
    print(contentController.bookmarkedWebinars.length);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          title: const Text('Bookmark'),
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: 10),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryColor,
            ),
            dividerColor: Colors.transparent,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Obx(
                      () {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 9 / 14.5,
                          ),
                          itemCount:
                              contentController.bookmarkedWebinars.value.length,
                          itemBuilder: (context, index) {
                            var content = contentController
                                .bookmarkedWebinars.value[index];

                            print(content.toString());
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
                        );
                      },
                    ),
                  ],
                ),
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
