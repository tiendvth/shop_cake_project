// File user_repository
// @project food
// @author phanmanhha198 on 15-07-2021
import 'package:network/network.dart';

abstract class ProfileRepository {
  //Future login(String username, String password);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;

  ProfileRepositoryImpl(this._dio);

  // @override
  // Future<Map<String,dynamic>> login(String username, String password) async {
  //    final result = await _dio.post("iam/api/v0/login-with-ldap",
  //       data: {"username": username, "password": password});
  //    return result.data as Map<String,dynamic>;
  // }
}
