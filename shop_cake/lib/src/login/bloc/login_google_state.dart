part of 'login_google_cubit.dart';

@immutable
abstract class LoginGoogleState {}

class LoginGoogleInitial extends LoginGoogleState {}
class LoginGoogleLoading extends LoginGoogleState {}
class LoginGoogleSuccess extends LoginGoogleState {
  final UserCredential userCredential;
  LoginGoogleSuccess(this.userCredential);
}
class LoginGoogleFailed extends LoginGoogleState {
  final String message;
  LoginGoogleFailed(this.message);
}
