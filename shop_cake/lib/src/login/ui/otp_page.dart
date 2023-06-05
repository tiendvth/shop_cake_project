import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/src/login/repository/user_repository.dart';
import 'package:shop_cake/utils/utils.dart';

class OtpPage extends StatefulWidget {
  final phone;
  final loginBoolean;

  const OtpPage({Key? key, this.phone, this.loginBoolean = false})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final userRepository = UserRepositoryImpl();
  TextEditingController otpEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Xác thực OTP',
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: FontColor.colorFF3366,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      length: 6,
                      // obscureText: true,
                      // obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          activeColor: FontColor.colorFF3366,
                          inactiveFillColor: FontColor.colorFFFFFF,
                          selectedFillColor: Colors.white),
                      // cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: otpEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 12,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (otpEditingController.text.length == 6) {
                try {
                  showLoading(context);
                  if (widget.loginBoolean) {
                    final result = await userRepository.verify_login(
                        widget.phone, otpEditingController.text);
                    closeLoading(context);
                    Navigator.pop(context);
                    context.read<AuthenticationBloc>().add(
                            AppLoginSuccessEvent({
                          "accessToken": result['accessToken'],
                          "refreshToken": result['refreshToken']
                        }));
                  } else {
                    final result = await userRepository.verify_register(
                        widget.phone, otpEditingController.text);
                    closeLoading(context);
                    if ((result as Response).statusCode == 200) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showDialogMessage(context, "Tạo tài khoản thành công",
                          checkBack: false);
                    } else {
                      showDialogMessage(
                          context, (result as Response).statusMessage);
                    }
                  }
                } catch (error) {
                  closeLoading(context);
                  showDialogMessage(
                      context, "Đã có lỗi xảy ra bui lòng thử lại",
                      checkBack: false);
                }
              } else {
                showDialogMessage(context, "Mã OTP không hợp lệ",
                    checkBack: false);
              }
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: FontColor.colorFF3366),
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: const Center(
                child: Text(
                  'Tiếp tục',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
