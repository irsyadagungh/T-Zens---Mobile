import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_page_organization_controller.dart';

class HistoryPageOrganizationView
    extends GetView<HistoryPageOrganizationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HistoryPageOrganizationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HistoryPageOrganizationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
