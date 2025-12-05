import 'package:get/get.dart';

import '../notification_model.dart';

class NotificationProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return NotificationModel.fromJson(map);
      if (map is List)
        return map.map((item) => NotificationModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<NotificationModel?> getNotification(int id) async {
    final response = await get('notification/$id');
    return response.body;
  }

  Future<Response<NotificationModel>> postNotification(
          NotificationModel notification) async =>
      await post('notification', notification);
  Future<Response> deleteNotification(int id) async =>
      await delete('notification/$id');
}
