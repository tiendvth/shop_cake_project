import 'package:network/network.dart';
import 'package:shop_cake/auth/AuthServiceImpl.dart';

abstract class ProfileUserRepository {
  Future profileUser();

  Future removeDeviceToken(device_token);
}

class ProfileUserRepositoryImpl implements ProfileUserRepository {
  final Dio _dio;

  ProfileUserRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> profileUser() async {
    final result = await Dio(BaseOptions(headers: {
      "Authorization": "Bearer ${AuthServiceImpl().getAccessToken()}"
    })).get(
      "https://accounts.metawayholdings.vn/api/account/information",
    );
    return result.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> removeDeviceToken(device_token) async {
    final result = await _dio.post(
      "/api/v1/device-tokens/deactivate",
      data: {
        "token": "$device_token"
      }
    );
    return result.data as Map<String, dynamic>;
  }
}
