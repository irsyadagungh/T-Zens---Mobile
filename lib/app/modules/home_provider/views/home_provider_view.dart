import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/modules/add/views/add_view.dart';
import 'package:tzens/app/modules/detailPage/views/detail_page_view.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/top_app_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../controllers/home_provider_controller.dart';

class HomeProviderView extends GetView<HomeProviderController> {
  final auth = Get.find<AuthController>();
  final webinar = Get.find<ContentController>();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      backgroundColor: customWhite,
      body: CustomScrollView(
        slivers: [
          TopAppBar(
            auth: auth,
            title: Routes.getTitleFromRoute(Get.currentRoute),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
                bottom: kToolbarHeight + kFloatingActionButtonMargin),
            sliver: Obx(
              () => SliverList.builder(
                  itemCount: webinar.contentList.length,
                  itemBuilder: (context, index) {
                    WebinarModel content = webinar.contentList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          // Get.to(() => DetailPageView(model: content));
                        },
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network("${content.photo}")),
                        title: Text("${content.title}"),
                        subtitle: Text(
                          "${content.description}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () {
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
                                        title: Text("Delete"),
                                        leading: Icon(Icons.delete),
                                      ),
                                      ListTile(
                                        title: Text("View"),
                                        leading:
                                            Icon(Icons.remove_red_eye_rounded),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      bottomNavigationBar: Obx(
        () => WaterDropNavBar(
            bottomPadding: 20,
            waterDropColor: Theme.of(context).colorScheme.primary,
            barItems: [
              BarItem(
                  filledIcon: Icons.event, outlinedIcon: Icons.event_outlined),
              BarItem(
                  filledIcon: Icons.group, outlinedIcon: Icons.group_outlined),
              BarItem(
                  filledIcon: Icons.person, outlinedIcon: Icons.person_outlined)
            ],
            selectedIndex: controller.selectedIndex.value,
            onItemSelected: (index) {
              controller.selectedIndex.value = index;
            }),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: [
          FloatingActionButton(
            heroTag: 'add_event',
            onPressed: () {
              Get.to(() => AddView());
            },
            tooltip: 'Add Event',
            child: Icon(Icons.event_note),
          ),
          FloatingActionButton(
            heroTag: 'add_group',
            onPressed: () {},
            tooltip: 'Add Group',
            child: Icon(Icons.group_add),
          ),
        ],
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }
}
