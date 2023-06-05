// File APIClient
// @project food
// @author phanmanhha198 on 13-07-2021
part of network;

class APIClient {
  late final Dio _dio;

  APIClient.init(
      {Config? config,
      HeaderAuthorized? headerAuthorized,
      MsgErrorHandler? msgErrorHandler,
      List<Interceptor>? interceptors}) {
    final dioConfig = config;
    _dio = Dio(dioConfig?.toOptions());
    setInterceptors(
        interceptors ?? List.empty(), headerAuthorized, msgErrorHandler);
  }

  APIClient.publish({Config? config}){
    final dioConfig = config;
    _dio = Dio(dioConfig?.toOptions());
    setLog();
  }

  setLog(){
    //add log without mode release
    if (!kReleaseMode) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  setInterceptors(List<Interceptor> interceptors,
      HeaderAuthorized? headerAuthorized, MsgErrorHandler? msgErrorHandler) {
    setLog();
    //add interceptor
    _dio.interceptors.addAll([
      HeaderInterceptor(headerAuthorized),
      AuthorizedInterceptor(_dio, headerAuthorized),
      ErrorHandleInterceptor(msgErrorHandler),
      ...interceptors
    ]);
  }

  Dio get() => _dio;
}
