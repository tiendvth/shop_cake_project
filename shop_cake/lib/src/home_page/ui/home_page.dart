import 'package:flutter/material.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/home_page/components/body.dart';
import 'package:shop_cake/src/home_page/components/upper_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children:  const [
          UpperBody(),
          Body(),
        ],
      ),
    );
  }
}