import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/controllers/messages.dart';
import 'package:tzens/app/data/models/registration_event_model_model.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:tzens/app/utils/function/SnackBar.dart';
import 'package:tzens/app/utils/widget/detail_sliverAppBar.dart';
import 'package:tzens/app/utils/widget/large_button.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  DetailPageView({Key? key, required this.model}) : super(key: key);

  final WebinarModel model;
  final controller = Get.put(DetailPageController());
  final contentC = Get.find<ContentController>();
  final authC = Get.find<AuthController>();
  final messageC = Get.find<Messages>();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    contentC.content = model;
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
                                  "${contentC.content.title}",
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
                                            "${contentC.content.date}",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Icon(Icons.access_time),
                                        Text(
                                            "${contentC.content.time!.startTime} - ${contentC.content.time!.endTime}")
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
                                        Text("${contentC.content.location}")
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
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  clipBehavior: Clip.antiAlias,
                                  child: contentC.content.administrator!
                                              .photoUrl !=
                                          ""
                                      ? Image.network(
                                          "${contentC.content.administrator!.photoUrl}",
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        )
                                      : Icon(Icons.person),
                                ),
                                title: Text(
                                    "${contentC.content.administrator!.name}"),
                                subtitle: Text(
                                    "${contentC.content.administrator!.email}"),
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
                              "${contentC.content.description}",
                            ),
                            Divider(),
                          ],
                        ),

                        /** BENEFIT */
                        contentC.content.benefits?[0] != ""
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
                                    "- ${contentC.content.benefits!.join("\n- ")}",
                                  ),
                                  Divider(),
                                ],
                              )
                            : SizedBox(height: 0),

                        /** PREQUISITE */
                        contentC.content.prerequisite?[0] != ""
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
                                    "- ${contentC.content.prerequisite!.join("\n- ")}",
                                  ),
                                  Divider(),
                                ],
                              )
                            : SizedBox(height: 0),

                        /** CONTACT */
                        contentC.content.contact?[0].name != "" &&
                                contentC.content.contact?[0].phone != ""
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
                                  for (var contact
                                      in contentC.content.contact!) ...[
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Row(
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
                                      TextButton(
                                        onPressed: () {
                                          Get.bottomSheet(
                                            Container(
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Registered Users",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Divider(),
                                                  SizedBox(
                                                    height:
                                                        300, // Set a fixed height for the list
                                                    child: ListView.builder(
                                                      itemCount: contentC
                                                          .registeredUsers
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var user = contentC
                                                                .registeredUsers[
                                                            index];
                                                        return ListTile(
                                                          leading: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            child: user.imageProfile !=
                                                                        null &&
                                                                    user.imageProfile !=
                                                                        ""
                                                                ? Image.network(
                                                                    user.imageProfile!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: 40,
                                                                    height: 40,
                                                                  )
                                                                : Initicon(
                                                                    text:
                                                                        user.name ??
                                                                            "?",
                                                                    size: 40,
                                                                  ),
                                                          ),
                                                          title: Text(
                                                              user.name ??
                                                                  "No Name"),
                                                          subtitle: Text(
                                                              user.createdAt ??
                                                                  "No Date"),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("See All"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Obx(
                                  () => contentC.registeredUsers.isNotEmpty
                                      ? AvatarStackWithCounter(
                                          registrationModel: controller
                                              .contentC.registeredUsers,
                                          size: 40,
                                          maxDisplay:
                                              3, // tampil max 3 avatar, sisanya jadi counter
                                        )
                                      : Center(
                                          child: Text(
                                            "No registered users yet.",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
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
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                authC.bookmarkWebinar(contentC.content.id!);
                controller.update();
              },
              icon: Obx(
                () => Icon(
                  authC.user.value.bookmark!.contains(contentC.content.id)
                      ? Icons.bookmark_outlined
                      : Icons.bookmark_border,
                  color: primaryColor,
                ),
              ),
            ),
            Expanded(
              child: LargeButton(
                color: WidgetStateColor.resolveWith((states) => primaryColor),
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
                          Get.dialog(AlertDialog(
                            title: Text("Register Confirmation"),
                            content: Text(
                                "Are you sure you want to register this event?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  contentC.registerWebinar(
                                      contentC.content.id!,
                                      contentC.content.administrator!.uid!,
                                      contentC.content.administrator!.token!,
                                      authC.user.value.uid!,
                                      contentC.content.photoUrl!,
                                      authC.user.value.name!,
                                      authC.user.value.photoUrl!,
                                      contentC.content.id!);
                                  // await messageC.sendNotificationToAdmin(adminToken, title, body);
                                  print("PRINT UNTUK ID CONTENT: " +
                                      contentC.content.id!);
                                  print("PRINT UNTUK ID USER: " +
                                      authC.user.value.uid!);
                                  print("PRINT UNTUK ID Admin: " +
                                      contentC.content.administrator!.uid!);
                                },
                                child: Text("Register"),
                              ),
                            ],
                          ))
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

class AvatarStackWithCounter extends StatelessWidget {
  final List<RegistrationEventModel> registrationModel;
  final double size;
  final int maxDisplay;

  const AvatarStackWithCounter({
    super.key,
    required this.registrationModel,
    this.size = 40,
    this.maxDisplay = 4, // jumlah maksimal avatar sebelum jadi counter
  });

  @override
  Widget build(BuildContext context) {
    final displayUsers = registrationModel.length > maxDisplay
        ? registrationModel.sublist(0, maxDisplay)
        : registrationModel;

    return SizedBox(
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < displayUsers.length; i++)
            Positioned(
              left: i * (size * 0.6), // jarak antar avatar
              child: _buildAvatar(displayUsers[i]),
            ),

          // Counter kalau user lebih banyak dari maxDisplay
          if (registrationModel.length > maxDisplay)
            Positioned(
              left: maxDisplay * (size * 0.6),
              child: CircleAvatar(
                radius: size / 2,
                backgroundColor: Colors.grey.shade400,
                child: Text(
                  "+${registrationModel.length - maxDisplay}",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(RegistrationEventModel registrationModel) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.blue.shade200,
      backgroundImage: (registrationModel.imageProfile != null &&
              registrationModel.imageProfile!.isNotEmpty)
          ? NetworkImage(registrationModel.imageProfile!)
          : null,
      child: (registrationModel.imageProfile == null ||
              registrationModel.imageProfile!.isEmpty)
          ? Text(
              registrationModel.name != null &&
                      registrationModel.name!.isNotEmpty
                  ? registrationModel.name![0].toUpperCase()
                  : "?",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : null,
    );
  }
}
