import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';

class WebinarProvider extends StatelessWidget {
  const WebinarProvider({
    super.key,
    required this.webinar,
  });

  final ContentController webinar;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding:
          EdgeInsets.only(bottom: kToolbarHeight + kFloatingActionButtonMargin),
      sliver: Obx(
        () => SliverList.builder(
            itemCount: webinar.contentList.length,
            itemBuilder: (context, index) {
              WebinarModel content = webinar.contentList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    // Get.to(() => DetailPageView(model: content));
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Theme.of(context).colorScheme.secondaryContainer,
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network("${content.photo}")),
                  title: Text("${content.title}"),
                  subtitle: Text(
                    "${content.description}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                          backgroundColor: Colors.white,
                          Container(
                            height: 200,
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text("Edit"),
                                  leading: Icon(Icons.edit),
                                ),
                                ListTile(
                                  title: Text("Delete"),
                                  leading: Icon(Icons.delete),
                                ),
                                ListTile(
                                  title: Text("View"),
                                  leading: Icon(Icons.remove_red_eye_rounded),
                                )
                              ],
                            ),
                          ));
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
