import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/utils/constant/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detail_history_organisasi_controller.dart';

class DetailHistoryOrganisasiView
    extends GetView<DetailHistoryOrganisasiController> {
  DetailHistoryOrganisasiView({Key? key, required this.organisasi})
      : super(key: key);

  final OrganizationModel organisasi;
  Future<void> launchUrl(Uri url) async {
    if (!await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Webinar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        /** OUTER CONTAINER */
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.shortestSide,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),

                /** BLUE CONTAINER */
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        organisasi.title ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Time
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Start",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "webinar.time?.startTime ?? '',",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Container(
                              child: CustomPaint(
                                painter: DashedLinePainter(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              Text(
                                "End",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "webinar.time?.endTime ?? ''",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              /** DIVIDER */
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 2,
                child: Expanded(
                  child: CustomPaint(
                    painter: DashedLinePainter(color: Colors.grey),
                  ),
                ),
              ),

              /** SECOND SECTION */
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.shortestSide / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Admin name"),
                                Text("organisasi.administrator!.name ?? ''"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email"),
                                Text("organisasi.administrator!.email ?? ''"),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location"),
                                // DISINI PENGGANTI LOCATION
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status"),
                                // DISINI PENGGANTI STATUS
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date"),
                              // DISINI PENGGANTI DATE
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              /** DIVIDER */
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 2,
                child: Expanded(
                  child: CustomPaint(
                    painter: DashedLinePainter(color: Colors.grey),
                  ),
                ),
              ),

              /** THIRD SECTION */
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(child: Text("Link")),
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            // if (webinar.link != null &&
                            //     webinar.link!.isNotEmpty) {
                            //   await launchUrl(Uri.parse(webinar.link!));
                            // } else {
                            //   return;
                            // }
                          },
                          child:
                              // organisasi.link!.isEmpty ||
                              //         organisasi.link == null ||
                              //         organisasi.link == ''
                              //     ?
                              Text(
                                  'This organisasi is offline, no link available')
                          // : Text(organisasi.link!),
                          ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final dashWidth = 5.0;
    final dashSpace = 3.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
