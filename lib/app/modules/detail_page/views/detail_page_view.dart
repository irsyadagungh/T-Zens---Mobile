import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/widget/detail_sliverAppBar.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  DetailPageView({Key? key, required this.model}) : super(key: key);

  WebinarModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppbarDetail(
            title: "${model.title}",
            image: "${model.photo}",
          ),
          SliverToBoxAdapter(
            /* OUTER CONTAINER */
            child: Container(
              color: customWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* INNER CONTAINER (TITLE SECTION) */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              /** DATE AND TIME */
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                          ),
                                          Text(
                                            "${model.date}",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Icon(Icons.access_time),
                                        Text(
                                            "${model.time!.startTime} - ${model.time!.endTime}")
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              Divider(),

                              /** LOCATION */
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        Text("${model.location}")
                                      ],
                                    ))
                                  ],
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
                                subtitle: Text("${model.administrator!.email}"),
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

                        /** BENEFIT */
                        model.benefits != null
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
                                    "- ${model.benefits!.join("\n- ")}",
                                  ),
                                  Divider(),
                                ],
                              )
                            : SizedBox(height: 0),

                        /** PREQUISITE */
                        model.prerequisite != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Prerequisites",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "- ${model.prerequisite!.join("\n- ")}",
                                  ),
                                  Divider(),
                                ],
                              )
                            : SizedBox(height: 0),

                        /** CONTACT */
                        model.contact != null
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          // child: LargeButton(
          //   text: "Register",
          //   onPressed: controller.isDisabled.value
          //       ? null
          //       : () {
          //           print("object");
          //         },
          // ),
          ),
    );
  }
}
