import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/modules/detail_history/views/detail_history_view.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/event_card.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  final webinar = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    webinar.readAllHistoryWebinar();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History'),
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
                text: "Not Started",
              ),
              Tab(
                text: "Started",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => TabBarView(
              children: [
                webinar.historyNotStarted.isEmpty
                    ? Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        itemCount: webinar.historyNotStarted.length,
                        itemBuilder: (context, index) {
                          var content = webinar.historyNotStarted[index];
                          return EventCard(
                            onTap: () {
                              Get.to(() => DetailHistoryView(), arguments: content.id);
                            },
                            title: content.title ?? '',
                            date: content.date ?? '',
                            status: content.status ?? '',
                            location: content.location ?? '',
                            startTime: content.time?.startTime ?? '',
                            endTime: content.time?.endTime ?? '',
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                            containerColor:
                                index % 2 == 0 ? primaryColor : Colors.white,
                          );
                        },
                      ),
                webinar.historyStarted.isEmpty
                    ? Center(
                        child: Text("No Data"),
                      )
                    : ListView.builder(
                        itemCount: webinar.historyStarted.length,
                        itemBuilder: (context, index) {
                          var content = webinar.historyStarted[index];
                          return EventCard(
                            onTap: () {
                              Get.to(() => DetailHistoryView(), arguments: content.id);
                            },
                            title: content.title ?? '',
                            date: content.date ?? '',
                            status: content.status ?? '',
                            location: content.location ?? '',
                            startTime: content.time?.startTime ?? '',
                            endTime: content.time?.endTime ?? '',
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                            containerColor:
                                index % 2 == 0 ? primaryColor : Colors.white,
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
