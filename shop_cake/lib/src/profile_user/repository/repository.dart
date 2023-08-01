import 'package:network/network.dart';

abstract class ProfileUserRepository {
  Future profileUser();

  Future removeDeviceToken(device_token);
}

class ProfileUserRepositoryImpl implements ProfileUserRepository {
  final Dio _dio;

  ProfileUserRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> profileUser() async {
    try {
      final result = await _dio.get("/api/auth/detail");
      return result.data as Map<String, dynamic>;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>> removeDeviceToken(device_token) async {
    final result = await _dio.post("/api/v1/device-tokens/deactivate",
        data: {"token": "$device_token"});
    return result.data as Map<String, dynamic>;
  }
}
