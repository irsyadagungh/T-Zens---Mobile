import 'package:get/get.dart';

import '../registration_organization_model_model.dart';

class RegistrationOrganizationModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return RegistrationOrganizationModel.fromJson(map);
      if (map is List)
        return map
            .map((item) => RegistrationOrganizationModel.fromJson(item))
            .toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<RegistrationOrganizationModel?> getRegistrationOrganizationModel(
      int id) async {
    final response = await get('registrationorganizationmodel/$id');
    return response.body;
  }

  Future<Response<RegistrationOrganizationModel>>
      postRegistrationOrganizationModel(
              RegistrationOrganizationModel
                  registrationorganizationmodel) async =>
          await post(
              'registrationorganizationmodel', registrationorganizationmodel);
  Future<Response> deleteRegistrationOrganizationModel(int id) async =>
      await delete('registrationorganizationmodel/$id');
}
