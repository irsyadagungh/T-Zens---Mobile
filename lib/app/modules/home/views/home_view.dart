import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    // if (auth == null || auth!.user == null) {
    //   // Handle the case where auth or auth.user is null
    //   return CircularProgressIndicator(); // or any other placeholder widget
    // }
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 230.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blue[100],
                                  ),
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.amber,
                                          ),
                                          Text(
                                            "${auth.user.username}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  height: 50,
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: Icon(Icons.notification_add_sharp),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                child: Text(
                                  "Morning, spread the benefits to many people",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: double.maxFinite,
                    width: 100,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return controller.pages[index];
                      },
                      itemCount: controller.pages.length,
                      onPageChanged: (value) {
                        controller.currentPages = value.obs;
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(() => WaterDropNavBar(
              backgroundColor: Colors.white,
              onItemSelected: (index) {
                controller.changePage(index);
                print(controller.pages[index]);
              },
              selectedIndex: controller.currentPages.value,
              barItems: [
                BarItem(
                  filledIcon: Icons.bookmark_rounded,
                  outlinedIcon: Icons.bookmark_border_rounded,
                ),
                BarItem(
                    filledIcon: Icons.favorite_rounded,
                    outlinedIcon: Icons.favorite_border_rounded),
              ],
            )),
      ),
    );
  }
}
