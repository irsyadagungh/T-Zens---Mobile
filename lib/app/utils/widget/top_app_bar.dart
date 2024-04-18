import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/modules/profile/views/profile_view.dart';
import 'package:tzens/app/utils/constant/color.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
    required this.auth,
  });

  final AuthController auth;

  @override
  Widget build(BuildContext context) {
    print(auth.user.name);

    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      title: Text("Home"),
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
                        auth.user.photoUrl == ""
                            ? ClipOval(
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${auth.user.photoUrl}"),
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${auth.user.name}"),
                            Text("${auth.user.email}")
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
