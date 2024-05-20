import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/detail_page/views/detail_page_view.dart';
import 'package:tzens/app/modules/home_provider/controllers/home_provider_controller.dart';

class WebinarProviders extends StatelessWidget {
  WebinarProviders({
    Key? key,
    required this.webinar,
    required this.controller,
  }) : super(key: key);

  final ContentController webinar;
  final HomeProviderController controller;
  final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding:
          EdgeInsets.only(bottom: kToolbarHeight + kFloatingActionButtonMargin),
      sliver: Obx(
        () => SliverList.builder(
          itemCount: webinar.contentListProvider.length,
          itemBuilder: (context, index) {
            WebinarModel content = webinar.contentListProvider[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => DetailPageView(model: content));
                  print("${authC.user.value.role}");
                },
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,

                /** PHOTO */
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "${content.photoUrl}",
                  ),
                ),

                /** TITLE & DESCRIPTION */
                title: Text(
                  "${content.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "${content.description}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                /** MORE VERT */
                trailing: IconButton(
                  onPressed: () async {
                    controller.onInit();
                    controller.idContent.value = await "${content.id}";
                    print("id = " + "${controller.idContent.value}");
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
                              onTap: () async {
                                Get.dialog(AlertDialog(
                                  title: Text("Delete"),
                                  content: Text(
                                      "Are you sure you want to delete this item?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        controller.onInit();
                                        controller.update();
                                        print("documentId = " +
                                            "${controller.idContent.value}");

                                        if (controller.idContent.value != "" &&
                                            controller.idContent.isNotEmpty) {
                                          try {
                                            webinar.deleteData(
                                                controller.idContent.value);
                                            controller
                                                .onInit(); // Memperbarui UI setelah penghapusan
                                          } catch (e) {
                                            print("Error deleting data: $e");
                                          }
                                        } else {
                                          print(
                                              "Document ID is empty or null, cannot delete the document.");
                                        }
                                      },
                                      child: Text("Delete"),
                                    )
                                  ],
                                ));
                              },
                              title: Text("Delete"),
                              leading: Icon(Icons.delete),
                            ),
                            ListTile(
                              title: Text("View"),
                              leading: Icon(Icons.remove_red_eye_rounded),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
