// File authorized_interceptor
// @project food
// @author phanmanhha198 on 13-07-2021

part of 'interceptor.dart';

typedef RefreshToken = Future<void> Function(BaseOptions baseOptions);

class HeaderAuthorized {
  final String? Function()? accessToken;
  final String? type;
  final RefreshToken? refreshToken;

  HeaderAuthorized({this.accessToken, this.type, this.refreshToken});

  String get token => "$type ${accessToken?.call()}";

  bool get isExistToken => accessToken?.call() != null;
}

class AuthorizedInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;
  final HeaderAuthorized? headerAuthorized;

  AuthorizedInterceptor(this._dio, this.headerAuthorized);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async{
    // Assume 401 stands for token expired
    if (err.response?.statusCode == HttpStatus.unauthorized &&
        headerAuthorized?.isExistToken == true) {
      try {
        var options = err.response!.requestOptions;
        // If the token has been updated, repeat directly.
        final token = headerAuthorized?.token;
        if (token != options.headers[HttpHeaders.authorizationHeader]) {
          options.headers[HttpHeaders.authorizationHeader] = token;
          //repeat
          final result = await _dio.fetch(options);
          return handler.resolve(result);
        }
        await headerAuthorized?.refreshToken?.call(_dio.options);
        //update accessToken
        options.headers[HttpHeaders.authorizationHeader] =
            headerAuthorized?.token;
        //repeat
        final result = await _dio.fetch(options);
        return handler.resolve(result);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
