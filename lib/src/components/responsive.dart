import 'package:flutter/material.dart';

// File responsive
// @project food
// @author phanmanhha198 on 15-08-2021

class Responsive extends StatelessWidget {
  const Responsive({Key? key, required this.mobile, this.tablet, this.desktop}) : super(key: key);

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  static const breakpoint1 = 800;
  static const breakpoint2 = 1200;

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < breakpoint1;

  static bool isMobileSize(double width) => width < breakpoint1;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < breakpoint2 && MediaQuery.of(context).size.width >= breakpoint1;

  static bool isTabletSize(double width) => width < breakpoint2 && width >= breakpoint1;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= breakpoint2;

  static bool isDesktopSize(double width) => width >= breakpoint2;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return OrientationBuilder(
      builder: (context, orientation) {
        if (width >= breakpoint2) {
          return desktop ?? tablet ?? mobile;
        } else if (width >= breakpoint1) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
