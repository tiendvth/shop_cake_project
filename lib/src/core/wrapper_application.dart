import 'package:common/src/auth/auth.dart';
import 'package:flutter/material.dart';

// File WrapperApplication
// @project food
// @author phanmanhha198 on 10-07-2021
class WrapperApplication extends StatelessWidget {
  final Widget child;
  final AuthService authService;

  const WrapperApplication(
      {Key? key, required this.child, required this.authService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthService>(
      create: (BuildContext context) {
        return authService;
      },
      child: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          final authService = RepositoryProvider.of<AuthService>(context);
          return AuthenticationBloc(authService)..add(AppLoadedWithAuth());
        },
        child: child,
      ),
    );
  }
}
