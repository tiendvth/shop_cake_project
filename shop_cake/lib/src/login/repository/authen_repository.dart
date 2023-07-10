// File user_repository
// @project food
// @author phanmanhha198 on 15-07-2021
import 'package:network/network.dart';

abstract class AuthenRepository {
  Future login(String username, String password);
}

class AuthenRepositoryImpl implements AuthenRepository {
  final Dio _dio;

  AuthenRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final result = await _dio.post(
        "api/auth/signin",
        data: {
          "username": username,
          "password": password,
        },
      );
      return result.data as Map<String, dynamic>;
    } catch (e) {
      throw e;
    }
  }
}
