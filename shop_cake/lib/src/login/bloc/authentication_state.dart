part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {}

class LoadingState extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoading extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginSuccess extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginFailure extends AuthenticationState {
  final String message;

  LoginFailure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
