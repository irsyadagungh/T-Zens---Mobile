import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/routes/app_pages.dart';
import 'package:tzens/app/utils/constant/color.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String location;
  final String startTime;
  final String endTime;
  final Color color;
  final Color containerColor;

  EventCard({
    required this.title,
    required this.date,
    required this.status,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_HISTORY);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                  left: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                  right: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: containerColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          startTime,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                            child: CustomPaint(
                                painter: TicketPainter(color: color))),
                        SizedBox(width: 20.0),
                        Text(
                          endTime,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            /** DIVIDER */
            Container(
              color: containerColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 13.0,
                    height: 20.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                          right: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: color,
                    ),
                  ),
                  SizedBox(
                    width: 13.0,
                    height: 20.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                          left: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /** END DIVIDER */

            /** THE BOTTOM OF THE TICKET */
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                  left: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                color: containerColor,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: color,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    location,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketPainter extends CustomPainter {
  final Color color;

  TicketPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dashWidth = 15.0; // Meningkatkan panjang garis lebih besar
    final dashSpace = 10.0; // Meningkatkan jarak antar garis lebih besar
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
