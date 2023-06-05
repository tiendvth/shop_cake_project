
import 'dart:io';

import 'package:common/common.dart';
import 'package:shop_cake/auth/AuthServiceImpl.dart';
import 'package:shop_cake/network/config.dart';

var device_token = '';
final apiProvider = APIClient.init(
    config: BuildConfig(),
    headerAuthorized: HeaderAuthorized(
        accessToken: () {
          return AuthServiceImpl().getAccessToken();
        },
        type: "Bearer",
        refreshToken: (dio) async {
          // final refreshToken = AuthServiceImpl().getRefreshToken();
          // final result = await UserRepositoryImpl(clientRefresh)
          //     .refreshToken(refreshToken);
          // final accessTokenNew = result['data']["access_token"];
          // final refreshTokenNew = result['data']["refreshToken"];
          // final data = {
          //   "accessToken": accessTokenNew,
          //   "refreshToken": refreshTokenNew
          // };
          // await AuthServiceImpl().setData(data);
        }),
    msgErrorHandler: MsgErrorHandler(
        msgTimeOut: "Không thể kết nối vui lòng thử lại",
        msgNetworkOther: "network fail",
        handlerDioErrorTypeResponse: (dioError) {
          final data = dioError.response?.data;
          return data == null
              ? dioError
              : dioError.copyWith(error: data["message"]);
        }),
    interceptors: []).get();

final clientRefresh = APIClient.publish(config: BuildConfig()).get();
