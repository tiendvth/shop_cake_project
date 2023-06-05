// File user_repository
// @project food
// @author phanmanhha198 on 15-07-2021
import 'package:firebase_auth/firebase_auth.dart';
import 'package:network/network.dart';
import 'package:shop_cake/src/login/ui/login.dart';

abstract class AuthenRepository {
  Future login(String username, String password);
}

class AuthenRepositoryImpl implements AuthenRepository {
  final Dio _dio;

  AuthenRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    final result = await _dio.post(
      "/api/v1/accounts/login",
      data: {
        "username": username,
        "password": password,
      },
    );
    return result.data as Map<String, dynamic>;
  }
}
