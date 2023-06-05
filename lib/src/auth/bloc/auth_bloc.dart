part of auth;

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc(this.authService) : super(const AuthenticationState.unknown()) {
    on<AppLoadedWithAuth>((event, emit) => _onAppLoadedWithAuth(event, emit));
    on<AppLoginSuccessEvent>((event, emit) => _onAppLoginSuccessEvent(event, emit));
    on<AppLogoutEvent>((event, emit) => _onAppLogoutEvent(event, emit));
    on<AppOpenLoginEvent>((event, emit) => _onAppOpenLoginEvent(event, emit));
  }

  _onAppLoadedWithAuth(
    AppLoadedWithAuth event,
    Emitter<AuthenticationState> emit,
  ) async {
    var isLogin = await authService.isLogin();
    if (isLogin) {
      emit(const AuthenticationState.authenticated());
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  _onAppLoginSuccessEvent(
    AppLoginSuccessEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    authService.setData(event.data);
    emit(const AuthenticationState.authenticated());
  }

  _onAppLogoutEvent(
    AppLogoutEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    authService.logout();
    emit(AuthenticationState.unauthenticated(message: event.message));
  }

  _onAppOpenLoginEvent(
    AppOpenLoginEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(const AuthenticationState.openLogin());
  }
}
