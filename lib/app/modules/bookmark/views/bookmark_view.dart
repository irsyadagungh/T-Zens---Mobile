import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/modules/detail_page/views/detail_page_view.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text('Bookmark'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 9 / 14.5,
                    ),
                    itemCount:
                        contentController.bookmarkedWebinars.length,
                    itemBuilder: (context, index) {
                      var content =
                          contentController.bookmarkedWebinars[index];

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
    );
  }
}
