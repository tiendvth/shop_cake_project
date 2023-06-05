import 'package:flutter/material.dart';

class IRoute {
  final String path;
  final Widget Function(BuildContext context) builder;

  IRoute({required this.path,required this.builder});
  
  bool isRoute(RouteSettings settings) {
    if(settings.name == null) return false;
    final uri = Uri.tryParse(settings.name!);
    final currentUri = Uri.tryParse(path);
    if(uri == null || currentUri == null || uri.pathSegments.length != currentUri.pathSegments.length) return false;
    final checkPath = List.generate(uri.pathSegments.length, (index) => uri.pathSegments[index] == currentUri.pathSegments[index] || uri.pathSegments[index].contains(":"));
    return checkPath.firstWhere((element) => element == false, orElse: () => true,);
  }

  Map<String, dynamic> argumentsFromSettings(RouteSettings settings){
    final Map<String, dynamic> args = {};
    if(isRoute(settings)){
      final uri = Uri.tryParse(settings.name!);
      final currentUri = Uri.tryParse(path);
      for (var i = 0; i < uri!.pathSegments.length; ++i) {
        final currentPath = currentUri!.pathSegments[i];
        final uriPath = uri.pathSegments[i];
        if(currentPath.contains(":")){
          final key = currentPath.replaceFirst(":", "");
          final value = uriPath;
          args[key] = value;
        }
      }
      args.addAll(uri.queryParameters);
    }
    return args;
  }

  PageRoute generateRouteRoot(RouteSettings settings, {Widget? child}){
      final argsFromPath = argumentsFromSettings(settings);
      final newSettings = RouteSettings(name: settings.name, arguments: {"params": argsFromPath,"arguments": settings.arguments});
      return MaterialPageRoute(builder: (context) => builder(context),settings: newSettings);
  }
}

