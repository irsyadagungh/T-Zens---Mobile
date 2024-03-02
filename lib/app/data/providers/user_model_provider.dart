import 'package:get/get.dart';

import '../models/user_model_model.dart';

class UserModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UserModel.fromJson(map);
      if (map is List)
        return map.map((item) => UserModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserModel?> getUserModel(int id) async {
    final response = await get('usermodel/$id');
    return response.body;
  }

  Future<Response<UserModel>> postUserModel(UserModel usermodel) async =>
      await post('usermodel', usermodel);
  Future<Response> deleteUserModel(int id) async =>
      await delete('usermodel/$id');
}
