// File error_handle_interceptor
// @project food
// @author phanmanhha198 on 13-07-2021
part of 'interceptor.dart';

class ErrorHandleInterceptor extends InterceptorsWrapper {
  final MsgErrorHandler? msgErrorHandler;

  ErrorHandleInterceptor(this.msgErrorHandler);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectTimeout:
        handler.reject(err.copyWith(error: msgErrorHandler?.msgTimeOut));
        break;
      case DioErrorType.cancel:
      case DioErrorType.response:
        handler.reject(msgErrorHandler?.handlerDioErrorTypeResponse == null
            ? err
            : msgErrorHandler!.handlerDioErrorTypeResponse!(err));
        break;
      default:
        handler.reject(err.copyWith(error: msgErrorHandler?.msgNetworkOther));
        break;
    }
  }
}

class MsgErrorHandler {
  final String? msgTimeOut;
  final String? msgNetworkOther;
  final DioError Function(DioError dioError)? handlerDioErrorTypeResponse;

  MsgErrorHandler(
      {this.msgTimeOut,
      this.msgNetworkOther,
      this.handlerDioErrorTypeResponse});
}

extension DioErrorExtension on DioError {
  copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioErrorType? type,
    dynamic error,
  }) {
    return DioError(
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
    );
  }
}
