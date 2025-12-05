import 'package:get/get.dart';

import '../registration_event_model_model.dart';

class RegistrationEventModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return RegistrationEventModel.fromJson(map);
      if (map is List)
        return map
            .map((item) => RegistrationEventModel.fromJson(item))
            .toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<RegistrationEventModel?> getRegistrationEventModel(int id) async {
    final response = await get('registrationeventmodel/$id');
    return response.body;
  }

  Future<Response<RegistrationEventModel>> postRegistrationEventModel(
          RegistrationEventModel registrationeventmodel) async =>
      await post('registrationeventmodel', registrationeventmodel);
  Future<Response> deleteRegistrationEventModel(int id) async =>
      await delete('registrationeventmodel/$id');
}
