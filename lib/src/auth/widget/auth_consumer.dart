part of auth;

class AuthConsumer extends StatefulWidget {
  final bool isAuth;
  final Widget Function() home;
  final Widget Function() login;

  const AuthConsumer(
      {Key? key,
        required this.isAuth,
        required this.home,
        required this.login})
      : super(key: key);

  @override
  State<AuthConsumer> createState() => _AuthConsumerState();
}

class _AuthConsumerState extends State<AuthConsumer> {
  _openLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => widget.login.call()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (widget.isAuth &&
            state.status != AuthenticationStatus.authenticated) {
          return widget.login.call();
        }
        return widget.home.call();
      },
      listener: (context, state) {
        if (!widget.isAuth && state.status == AuthenticationStatus.openLogin) _openLogin(context);
        if (widget.isAuth && state.status == AuthenticationStatus.unauthenticated) NavigatorManager.removeUntil(context);
      },
      buildWhen: (preState, currentState) {
        return widget.isAuth;
      },
    );
  }
}
