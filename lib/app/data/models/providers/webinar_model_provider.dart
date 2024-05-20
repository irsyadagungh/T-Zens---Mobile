import 'package:get/get.dart';

import '../webinar_model_model.dart';

class WebinarModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return WebinarModel.fromJson(map);
      if (map is List)
        return map.map((item) => WebinarModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<WebinarModel?> getWebinarModel(int id) async {
    final response = await get('webinarmodel/$id');
    return response.body;
  }

  Future<Response<WebinarModel>> postWebinarModel(
          WebinarModel webinarmodel) async =>
      await post('webinarmodel', webinarmodel);
  Future<Response> deleteWebinarModel(int id) async =>
      await delete('webinarmodel/$id');
}
