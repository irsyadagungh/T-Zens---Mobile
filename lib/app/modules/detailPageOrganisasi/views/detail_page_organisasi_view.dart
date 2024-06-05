import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/messages.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/function/SnackBar.dart';
import 'package:tzens/app/utils/widget/detail_sliverAppBar.dart';
import 'package:tzens/app/utils/widget/large_button.dart';

import '../controllers/detail_page_organisasi_controller.dart';

class DetailPageOrganisasiView extends GetView<DetailPageOrganisasiController> {
  DetailPageOrganisasiView({Key? key, required this.model}) : super(key: key);

  final OrganizationModel model;
  final controller = Get.put(DetailPageOrganisasiController());
  final contentC = Get.find<ContentController>();
  final authC = Get.find<AuthController>();
  final messageC = Get.find<Messages>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppbarDetail(
            title: "${model.title}",
            image: "${model.photoUrl}",
          ),
          SliverToBoxAdapter(
            /* OUTER CONTAINER */
            child: Container(
              color: customWhite,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* INNER CONTAINER (TITLE SECTION) */
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                          ),

                          /** TITLE SECTION */
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* TITLE */
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "${model.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Divider(),

                                /** Admin */
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    child: model.administrator!.photoUrl != ""
                                        ? Image.network(
                                            "${model.administrator!.photoUrl}",
                                          )
                                        : Icon(Icons.person),
                                  ),
                                  title: Text("${model.administrator!.name}"),
                                  subtitle:
                                      Text("${model.administrator!.email}"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    /** CONTENT */
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          /** DESCRIPTION */
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                "${model.description}",
                              ),
                              Divider(),
                            ],
                          ),

                          /** Description */
                          model.division?[0] != ""
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Benefit",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "- ${model.division!.join("\n- ")}",
                                    ),
                                    Divider(),
                                  ],
                                )
                              : SizedBox(height: 0),

                          /** CONTACT */
                          model.contact?[0].name != "" &&
                                  model.contact?[0].phone != ""
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contact",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    for (var contact in model.contact!) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text("${contact.name}"),
                                          ),
                                          Expanded(
                                            child: Text(" - "),
                                          ),
                                          Expanded(
                                            child: Text("${contact.phone}"),
                                          ),
                                        ],
                                      )
                                    ],
                                    Divider(),
                                  ],
                                )
                              : SizedBox(height: 0),

                          /** REGISTERED USER */
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Registered User",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  model.registeredAccount!.length > 10
                                      ? TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              Text("See all"),
                                              Icon(Icons
                                                  .arrow_forward_ios_rounded)
                                            ],
                                          ),
                                        )
                                      : SizedBox(height: 0),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: model.registeredAccount == null ||
                                        model.registeredAccount!.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No user registered yet",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          for (var user
                                              in model.registeredAccount!) ...[
                                            ClipOval(
                                              child: user.photoUrl != ""
                                                  ? Image.network(
                                                      "${user.photoUrl}",
                                                      width: 50,
                                                      height: 50,
                                                    )
                                                  : Icon(Icons.person),
                                            ),
                                            SizedBox(
                                                height:
                                                    8), // Optional: Add spacing between items
                                          ],
                                          Divider(),
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                // authC.bookmarkWebinar(model.id!);
              },
              icon: Obx(() => Icon(
                    authC.bookmarked.value == true
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  )),
            ),
            Expanded(
              child: LargeButton(
                text: "Register",
                onPressed: () async {
                  controller.isDisabled.value
                      ? controller.authC.user.value.role == "provider"
                          ? CustomSnackBar(
                              "You are a provider",
                              "You can't register this event",
                              Icons.error,
                              Colors.red,
                            )
                          : CustomSnackBar(
                              "Your profile is not complete",
                              "Please complete your profile first",
                              Icons.error,
                              Colors.red,
                            )
                      : {
                          contentC.registerOrganization(
                              model.id!, authC.user.value.uid!),
                          // await messageC.sendNotificationToAdmin(adminToken, title, body);
                          print(model.id),
                        };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
