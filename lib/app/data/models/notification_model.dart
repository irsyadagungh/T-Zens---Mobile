import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? title;
  String? body;
  bool? isRead;
  String? imageEventUrl;
  String? eventId;
  Timestamp? createdAt;

  NotificationModel(
      {this.id, this.title, this.body, this.isRead, this.imageEventUrl, this.eventId, this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['message'];
    isRead = json['isRead'];
    imageEventUrl = json['imageEventUrl'];
    eventId = json['eventId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['isRead'] = isRead;
    data['imageEventUrl'] = imageEventUrl;
    data['eventId'] = eventId;
    data['createdAt'] = createdAt;
    return data;
  }
}
