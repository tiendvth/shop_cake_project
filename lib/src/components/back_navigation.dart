import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// File back_navigation
// @project food
// @author phanmanhha198 on 16-07-2021
class BackNavigation extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const BackNavigation({Key? key, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalRoute.of(context)?.canPop == true
        ? IconButton(
            highlightColor: Colors.transparent,
            icon: Icon(
              CupertinoIcons.back,
              size: 30,
              color: color ?? Colors.black,
            ),
            onPressed: onPressed ?? () {
                    Navigator.of(context).pop();
                  })
        : Container();
  }
}
