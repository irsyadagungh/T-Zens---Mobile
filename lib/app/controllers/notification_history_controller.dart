import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tzens/app/data/models/notification_model.dart';

class NotificationHistoryController {
  RxList<NotificationModel> notificationHistoryList = <NotificationModel>[].obs;
  RxInt notifCount = 0.obs;

  late CollectionReference notifHistoryCollection =
      FirebaseFirestore.instance.collection('notification_history');

  Future<void> addNotificationHistory(
      String uid, String title, String message, String imageEventUrl, String eventId) async {
    try {
      final docRef = await notifHistoryCollection.add({
        'uid': uid,
        'title': title,
        'message': message,
        'isRead': false,
        'imageEventUrl': imageEventUrl,
        'eventId': eventId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await docRef.update({'id': docRef.id});
      print(
          "✅ Notification added with id: ${docRef.id}, uid: $uid, title: $title");
    } catch (e) {
      print("❌ Error adding notification history: $e");
    }
  }

  // Fetch notification history from Firestore (stream)
  void fetchNotificationHistory(String uid) {
    try {
      notifHistoryCollection
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        notificationHistoryList.value = querySnapshot.docs.map((doc) {
          return NotificationModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        notifCount.value = notificationHistoryList
            .where((notif) => notif.isRead == false)
            .length;

        print("Notification history updated.");
        print(
            "Fetched notifications: ${notificationHistoryList.map((e) => e.toJson()).toList()}");
        print("Total notifications: ${notifCount.value}");
      });
    } catch (e) {
      print("Error streaming notification history: $e");
    }
  }

  // update isRead status
  Future<void> markAsRead(String notificationId) async {
    try {
      await notifHistoryCollection.doc(notificationId).update({'isRead': true});
      notificationHistoryList.refresh();
      print("Notification $notificationId marked as read.");
    } catch (e) {
      print("Error marking notification as read: $e");
    }
  }
}
