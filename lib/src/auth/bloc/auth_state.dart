part of auth;

enum AuthenticationStatus { unknown, authenticated, unauthenticated, openLogin }

class AuthenticationState {
  final AuthenticationStatus status;
  final String? message;

  const AuthenticationState._({required this.status, this.message});

  const AuthenticationState.unknown()
      : this._(status: AuthenticationStatus.unknown);

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.openLogin()
      : this._(status: AuthenticationStatus.openLogin);

  const AuthenticationState.unauthenticated({String? message})
      : this._(status: AuthenticationStatus.unauthenticated, message: message);
}
