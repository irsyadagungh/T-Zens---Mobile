import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/detailPageOrganisasi/views/detail_page_organisasi_view.dart';
import 'package:tzens/app/modules/detail_history/views/detail_history_view.dart';
import 'package:tzens/app/modules/history_page_organization/controllers/history_page_organization_controller.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';
import 'package:tzens/app/utils/widget/event_card.dart';

class HistoryPageOrganizationView
    extends GetView<HistoryPageOrganizationController> {
  final contentController = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    // Dummy data for historyNotStarted

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History Organization'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              // Displaying historyNotStarted list
              // historyNotStarted.isEmpty
              // ? Center(
              //     child: Text('No Data'),
              //   )
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.601,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  // OrganizationModel content = contentController
                  //     .contentListOrganizationUser[index];
                  return GestureDetector(
                    onTap: () {
                      // Get.to(
                      //     // () => DetailPageOrganisasiView(model: content));
                    },
                    child: CardPotret(
                      photo:
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fid%2Ffoto-foto%2Finternet&psig=AOvVaw307y9eEfgpjA11i-q5WrI5&ust=1717933770914000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLiD25L4y4YDFQAAAAAdAAAAABAE",
                      title: "tes",
                      date: "20/02/0100",
                      status: "done",
                    ),
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
