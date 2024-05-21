import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/home_provider/controllers/home_provider_controller.dart';

class OrganisasiProvider extends StatelessWidget {
  const OrganisasiProvider(
      {super.key, required this.organisasi, required this.controller});
  final ContentController organisasi;
  final HomeProviderController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding:
          EdgeInsets.only(bottom: kToolbarHeight + kFloatingActionButtonMargin),
      sliver: Obx(() => SliverList.builder(
          itemCount: organisasi.contentListProvider.length,
          itemBuilder: (context, index) {
            WebinarModel content = organisasi.contentListProvider[index];
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network("${content.photo}"),
                ),
                title: Text("${content.title}"),
                subtitle: Text(
                  "${content.description}",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    controller.onInit();
                    late Rx<String?> id =
                        organisasi.contentListProvider[index].id.obs;
                    print(id);
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
                              onTap: () {
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
                                        String? documentId = await id.value;
                                        print(documentId);
                                        if (documentId != null &&
                                            documentId.isNotEmpty) {
                                          try {
                                            await organisasi
                                                .deleteData(documentId);
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
          })),
    );
  }
}
