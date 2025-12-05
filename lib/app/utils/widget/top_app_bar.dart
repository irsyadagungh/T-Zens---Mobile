import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/notification_history_controller.dart';
import 'package:tzens/app/modules/notification/views/notification_view.dart';
import 'package:tzens/app/modules/profile/views/profile_view.dart';
import 'package:tzens/app/modules/search_page/views/search_page_view.dart';
import 'package:tzens/app/utils/constant/color.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
    required this.auth,
    required this.notificationController,
    required this.title,
  });

  final AuthController auth;
  final String title;
  final NotificationHistoryController notificationController;

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    print(auth.user.value.name);

    return SliverAppBar(
      backgroundColor: customWhite,
      surfaceTintColor: Colors.white,
      title: Text(title),
      automaticallyImplyLeading: false,
      expandedHeight: 190,
      collapsedHeight: 120,
      toolbarHeight: 65,
      pinned: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        titlePadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        centerTitle: true,
        background: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Content AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile
                    Obx(() => Row(
                          children: [
                            auth.user.value.photoUrl == ""
                                ? ClipOval(
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${auth.user.value.photoUrl}"),
                                  ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${auth.user.value.name}"),
                                Text("${auth.user.value.email}")
                              ],
                            ),
                          ],
                        )),

                    // Notification
                    Obx(() => Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(() => NotificationView(),
                                    arguments: notificationController
                                        .notificationHistoryList);
                              },
                              icon: Icon(Icons.notifications_active_outlined),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor)),
                            ),
                            if (notificationController.notifCount.value > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Text(
                                    '${notificationController.notifCount.value}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),

        // Search
        title: TextField(
          focusNode: _focusNode,
          readOnly: true,
          onTap: () {
            Get.to(() => SearchPageView());
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            hintText: "Search",
            hintStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
