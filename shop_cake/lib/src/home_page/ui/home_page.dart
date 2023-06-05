
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/generated/l10n.dart';
import 'package:shop_cake/widgets/c_text.dart';

class HomePage extends StatefulWidget {
  final AuthenticationStatus? openLogin;

  const HomePage({Key? key, this.openLogin}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Center(
          child: CText(
            text: Translate.of(context).home,
            textColor: FontColor.colorText231F20,
          ),
        ),
      ),
    );
  }
}
