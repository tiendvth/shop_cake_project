import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/generated/l10n.dart';
import 'package:shop_cake/src/my_order/ui/my_order_page.dart';
import 'package:shop_cake/widgets/c_text.dart';


class ProfilePage extends StatefulWidget {
  final AuthenticationStatus? openLogin;

  const ProfilePage({Key? key, this.openLogin}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            text: Translate.of(context).log_out,
            textColor: FontColor.colorText231F20,
            tappedText: () {
              // context.read<AuthenticationBloc>().add(AppLogoutEvent());
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyOrderPage()));
            },
          ),
        ),
      ),
    );
  }
}
