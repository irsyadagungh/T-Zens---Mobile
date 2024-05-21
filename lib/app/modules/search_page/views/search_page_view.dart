import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/detail_page/views/detail_page_view.dart';
import 'package:tzens/app/utils/constant/color.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  SearchPageView({Key? key}) : super(key: key);
  final contenteController = Get.find<ContentController>();
  final controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    contenteController.readDataUser();
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: customWhite,
            surfaceTintColor: Colors.white,
            expandedHeight: 130,
            collapsedHeight: 120,
            toolbarHeight: 65,
            pinned: true,
            centerTitle: true,
            title: Text("Pencarian"),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              centerTitle: true,
              title: TextField(
                onChanged: (value) {
                  contenteController.search(value);
                },
                onTap: () {},
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  hintText: "Search",
                  hintStyle: TextStyle(color: primaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: Obx(
              () => contenteController.contentListSearch.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "No Data",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    )
                  : SliverList.builder(
                      itemCount: contenteController.contentListUser.length,
                      itemBuilder: (context, index) {
                        WebinarModel content =
                            contenteController.contentListUser[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => DetailPageView(model: content));
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            width: 280,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${content.title}",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${content.description}",
                                                  maxLines: 3,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  overflow: TextOverflow.clip,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons
                                                        .free_cancellation_rounded),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text("${content.status}")
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            "${content.photo}",
                                            height: 100,
                                            width: 100,
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
