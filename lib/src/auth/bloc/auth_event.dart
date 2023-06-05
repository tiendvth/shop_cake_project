part of auth;

@immutable
abstract class AuthenticationEvent {}

class AppLoadedWithAuth extends AuthenticationEvent {}

class AppLoadedWithOutAuth extends AuthenticationEvent {}

class AppLoginSuccessEvent extends AuthenticationEvent {
  final dynamic data;

  AppLoginSuccessEvent([this.data]);
}

class AppLogoutEvent extends AuthenticationEvent {
  final String? message;

  AppLogoutEvent({this.message});
}

class AppOpenLoginEvent extends AppLogoutEvent {
  AppOpenLoginEvent({String? message}) : super(message: message);
}
