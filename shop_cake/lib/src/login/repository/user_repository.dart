// File user_repository
// @project Pindias
// @author phanmanhha198 on 15-07-2021
import 'package:network/network.dart';

abstract class UserRepository {
  Future login(String? username,String? password);

  Future register(String? username, String? email, String?  password);

  Future verify_login(phone, otp);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future login(String? username,String? password) async {
    try {
      final result = await Dio()
          .post("http://103.187.5.254:8090/api/auth/signin", data: {
        "username": username,
        "password": password,
      });
     if (result.statusCode == 200) {
        return result.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Future<Map<String, dynamic>> verify_login(phone, otp) async {
    final result = await Dio().post(
        "https://accounts.metawayholdings.vn/api/account/verify-login",
        data: {
          "email": "string",
          "phone": "$phone",
          "type": "phone",
          "verifyCode": "$otp"
        });
    return result.data as Map<String, dynamic>;
  }

  @override
  Future register(String? username, String? email, String?  password) async {
    try {
      final result = await Dio().post(
          "http://103.187.5.254:8090/api/auth/signup",
          data: {
            "email": email,
            "password": password,
            "username": username,
            "role": ["admin"]
          });
      if (result.statusCode == 200) {
        return result;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Có lỗi xảy ra!');
    }
  }

  @override
  Future verify_register(phone, otp) async {
    final result = await Dio().post(
        "https://accounts.metawayholdings.vn/api/account/verify-register",
        data: {
          "email": "string",
          "phone": "$phone",
          "type": "phone",
          "verifyCode": "$otp"
        });
    return result;
  }
}
