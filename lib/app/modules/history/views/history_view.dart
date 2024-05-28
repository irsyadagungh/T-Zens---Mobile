import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/event_card.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Belum dimulai'),
              Tab(text: 'Sudah dimulai'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return EventCard(
                    title: '',
                    date: '',
                    isFree: false,
                    location: '',
                    time: '',
                    link: '',
                    color: index % 2 == 0 ? Colors.white : Colors.black,
                    containerColor:
                        index % 2 == 0 ? primaryColor : Colors.white,
                  );
                },
              ),
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return EventCard(
                    title: '',
                    date: '',
                    isFree: false,
                    location: '',
                    time: '',
                    link: '',
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
    );
  }
}
