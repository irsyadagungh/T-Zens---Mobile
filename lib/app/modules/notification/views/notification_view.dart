import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/notification_history_controller.dart';
import 'package:tzens/app/data/models/notification_model.dart';
import 'package:tzens/app/utils/constant/color.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  RxList<NotificationModel> notificationHistory =
      Get.arguments as RxList<NotificationModel>;
  NotificationController controller = Get.put(NotificationController());
  NotificationHistoryController notificationHistoryController =
      Get.find<NotificationHistoryController>();

  @override
  Widget build(BuildContext context) {
    print("Notification History Length: ${notificationHistory.length}");
    return Scaffold(
        backgroundColor: customWhite,
        appBar: AppBar(
          backgroundColor: customWhite,
          title: Text('Notification History'),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: notificationHistory.length,
            itemBuilder: (context, index) {
              final notification = notificationHistory[index];
              return GestureDetector(
                onTap: (){
                  if(!(notification.isRead ?? true)){
                    notificationHistoryController.markAsRead(notification.id!);
                    notification.isRead = true;
                  }

                  Get.toNamed('/detail-history', arguments: notification.eventId);
                },
                child: Container(
                  color: notification.isRead! ? customWhite : Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          height: 70.h,
                          width: 50.w,
                          fit: BoxFit.cover,
                          notification.imageEventUrl ?? '',
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.event);
                          },
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        flex: 4,
                        child: Container(
                          // color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notification.title ?? '',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              SizedBox(
                                child: Text(notification.body ?? '',
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 3,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(height: 20),
                              Text(notification.createdAt != null
                                  ? controller.formatTimestamp(notification.createdAt!)
                                  : ''),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,child: Icon(
                          notification.isRead!
                              ? Icons.mark_email_read
                              : Icons.mark_email_unread,
                          color:
                              notification.isRead! ? Colors.green : Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
