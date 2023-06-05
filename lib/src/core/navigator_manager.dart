import 'package:flutter/cupertino.dart';

class NavigatorManager {
  static final navRoot = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRouteRoot(
      RouteSettings routeSetting, Widget initWidget) {
    return PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return initWidget;
        },
        transitionDuration: const Duration(milliseconds: 1));
  }

  static Future push(BuildContext context, Widget widget, {String? name}) {
    return Navigator.of(context)
        .push(SlideLeftRoute(widget: widget, name: name));
  }

  static Future pushFullScreen(BuildContext context, Widget widget,
      {bool fullscreenDialog = false, String? name}) {
    return Navigator.of(context, rootNavigator: true).push(SlideLeftRoute(
        widget: widget, fullscreenDialog: fullscreenDialog, name: name));
  }

  static Future pushRemoveUntil(BuildContext context, Widget widget,
      {String? name, rootNavigator = true}) {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .pushAndRemoveUntil(
            SlideLeftRoute(widget: widget, name: name), (route) => false);
  }

  static removeUntil(BuildContext context, {rootNavigator = false}) {
    Navigator.of(context, rootNavigator: rootNavigator)
        .popUntil((router) => router.isFirst);
  }
}

Future<Widget> buildPageAsync({widget = Widget}) async {
  return Future.microtask(() {
    return widget;
  });
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.0, 1.0, curve: Curves.ease))),
                child: widget,
              );
            });
}

class SlideLeftRoute extends CupertinoPageRoute {
  final String? name;
  final Object? arguments;

  SlideLeftRoute({widget, this.name, fullscreenDialog = false, this.arguments})
      : super(builder: (_) => widget, fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  RouteSettings get settings =>
      super.settings.copyWith(name: name, arguments: arguments);
}

mixin NestNavigationMixin<T extends StatefulWidget> on State<T> {
  GlobalKey<NavigatorState> get navigatorKey;

  Widget get child;

  RouteFactory? get onGenerateRoute => null;

  RouteFactory? get onUnknownRoute => null;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        onGenerateInitialRoutes: (route, path) {
          return [
            PageRouteBuilder(pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return child;
            })
          ];
        });
  }
}
