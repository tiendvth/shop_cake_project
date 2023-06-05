// File user_repository
// @project Pindias
// @author phanmanhha198 on 15-07-2021
import 'package:network/network.dart';

abstract class UserRepository {
  Future login(phone);

  Future register(phone);

  Future verify_login(phone, otp);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future login(phone) async {
    final result = await Dio()
        .post("https://accounts.metawayholdings.vn/api/account/login", data: {
      "email": "string",
      "password": "string",
      "phone": "$phone",
      "type": "phone"
    });
    return result;
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
  Future register(phone) async {
    final result = await Dio().post(
        "https://accounts.metawayholdings.vn/api/account/register",
        data: {
          "email": "string",
          "password": "string",
          "phone": "$phone",
          "type": "phone"
        });
    return result;
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
