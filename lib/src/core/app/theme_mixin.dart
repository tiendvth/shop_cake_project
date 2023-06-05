// File theme_mixin
// @project food
// @author phanmanhha198 on 15-08-2021
import 'package:flutter/material.dart';
import 'material_app.dart';

mixin ThemeMixin<T extends StatefulWidget> on State<T> implements ThemeConfig {
  @override
  void initState() {
    ThemeConfig.onChangeTheme = (ThemeMode themeMode){
      setState(() {
        this.themeMode = themeMode;
      });
    };
    super.initState();
  }

  @override
  void dispose() {
    ThemeConfig.onChangeTheme = null;
    super.dispose();
  }
}