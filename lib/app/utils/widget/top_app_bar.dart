import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/profile/views/profile_view.dart';
import 'package:tzens/app/modules/search_page/views/search_page_view.dart';
import 'package:tzens/app/utils/constant/color.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
    required this.auth,
    required this.title,
  });

  final AuthController auth;
  final String title;

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
                    Row(
                      children: [
                        Obx(() => auth.user.value.photoUrl == ""
                            ? ClipOval(
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${auth.user.value.photoUrl}"),
                              )),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text("${auth.user.value.name}")),
                            Obx(() => Text("${auth.user.value.email}"))
                          ],
                        ),
                      ],
                    ),

                    // Notification
                    IconButton(
                      onPressed: () {
                        Get.to(() => ProfileView());
                      },
                      icon: Icon(Icons.notifications_active_outlined),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor)),
                    )
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
            fillColor: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}
