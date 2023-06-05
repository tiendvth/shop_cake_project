// File user_repository
// @project food
// @author phanmanhha198 on 15-07-2021
import 'package:network/network.dart';

abstract class HomeRepository {
  //Future login(String username, String password);
  Future deviceToken(String? device_token);
}

class HomeRepositoryImpl implements HomeRepository {
  final Dio _dio;

  HomeRepositoryImpl(this._dio);

  // @override
  // Future<Map<String,dynamic>> login(String username, String password) async {
  //    final result = await _dio.post("iam/api/v0/login-with-ldap",
  //       data: {"username": username, "password": password});
  //    return result.data as Map<String,dynamic>;
  // }

  @override
  Future<Map<String,dynamic>> deviceToken(String? device_token) async {
     final result = await _dio.post("/api/v1/device-tokens",
        data: {
          "token": device_token,
          "type": "ANDROID"
        });
     return result.data as Map<String,dynamic>;
  }
}
