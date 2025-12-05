import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/modules/detailHistoryOrganisasi/views/detail_history_organisasi_view.dart';
import 'package:tzens/app/modules/history_page_organization/controllers/history_page_organization_controller.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';

class HistoryPageOrganizationView
    extends GetView<HistoryPageOrganizationController> {
  final controller = Get.put(HistoryPageOrganizationController());
  @override
  Widget build(BuildContext context) {
    // Dummy data for historyNotStarted

    return Scaffold(
      appBar: AppBar(
        title: Text('History Organization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.content.historyOrganization.isEmpty
            ? Center(
                child: Text('No Data'),
              )
            : Obx(() => GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 0.601,
                  ),
                  itemCount: controller.content.historyOrganization.length,
                  itemBuilder: (context, index) {
                    OrganizationModel content =
                        controller.content.historyOrganization[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () =>
                              DetailHistoryOrganisasiView(organisasi: content),
                        );
                      },
                      child: CardPotret(
                        photo: "${content.photoUrl}",
                        title: "${content.title}",
                        date: "${content.openRecruitment?.startDate}",
                        status: "Organization",
                      ),
                    );
                  },
                )),
      ),
    );
  }
}
