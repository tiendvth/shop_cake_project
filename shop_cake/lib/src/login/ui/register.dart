import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/generated/l10n.dart';
import 'package:shop_cake/src/app_home.dart';
import 'package:shop_cake/src/login/bloc/authentication_cubit.dart';
import 'package:shop_cake/src/login/bloc/login_google_cubit.dart';
import 'package:shop_cake/src/login/repository/user_repository.dart';
import 'package:shop_cake/src/login/ui/otp_page.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/c_button.dart';
import 'package:shop_cake/widgets/c_container.dart';
import 'package:shop_cake/widgets/c_image.dart';
import 'package:shop_cake/widgets/c_text.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class Register extends StatefulWidget {
  final AuthenticationStatus? openLogin;

  const Register({Key? key, this.openLogin}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _authenticationCubit = AuthenticationCubit();
  final userRepository = UserRepositoryImpl();
  final phoneController = TextEditingController();
  late bool effectLoading;

  @override
  void initState() {
    effectLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: true,
        child:
            // BlocProvider<LoginCubit>(
            //   create: (context) => loginCubit,
            //   child:
            Stack(
            children: [
              const CImage(
                assetsPath: Assets.imBgLogin,
                height: double.infinity,
                width: double.infinity,
              ),
              CContainer(
                height: double.infinity,
                width: double.infinity,
                backgroundColor: FontColor.colorText231F20.withOpacity(0.8),
                borderColor: FontColor.colorText231F20.withOpacity(0.8),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (AppBar().preferredSize.height + 100).spaceHeight,
                    CText(
                      text: "Đăng ký",
                      textColor: FontColor.colorFFFFFF,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.fontSize_24,
                    ),
                    20.spaceHeight,
                    CText(
                      text: "Đăng ký để tiếp tục",
                      textColor: FontColor.colorFFFFFF,
                      fontSize: FontSize.fontSize_16,
                    ),
                    50.spaceHeight,
                    CTextFormField(
                      backgroundColor: FontColor.colorText231F20.withOpacity(0.8),
                      height: 60,
                      hintText: 'Số điện thoại',
                      controller: phoneController,
                      textInputType: const TextInputType.numberWithOptions(),
                      onComplete: () {
                        //FocusManager.instance.primaryFocus?.dispose();
                      },
                      contentPadding:
                          const EdgeInsets.only(top: 21, bottom: 21, left: 24),
                    ),
                    40.spaceHeight,
                    BlocConsumer(
                        bloc: _authenticationCubit,
                        listener: (BuildContext context, state) {
                          if (state is LoadingState) {
                            effectLoading = false;
                          }
                          if (state is LoginSuccess) {
                            effectLoading = true;
                          }
                          if (state is LoginFailure) {
                            effectLoading = true;
                          }
                        },
                        builder: (BuildContext context, state) {
                          return CButton(
                            width: double.infinity,
                            height: 44,
                            bgColor: FontColor.colorFF3366,
                            title: 'Tiếp tục',
                            radius: 8,
                            fontSize: FontSize.fontSize_16,
                            fontWeight: FontWeight.w600,
                            fontColor: FontColor.colorFFFFFF,
                            checkLoading: effectLoading,
                            onPressed: () async {
                              // _authenticationCubit.login(emailController.text, pwdController.text, context);
                              if (phoneController.text.split(' ').isEmpty) {
                                showDialogMessage(
                                    context, 'Vui lòng nhập số điện thoại',
                                    checkBack: false);
                              } else if (phoneController.text.isEmpty) {
                                showDialogMessage(
                                    context, 'Vui lòng nhập số điện thoại',
                                    checkBack: false);
                              } else if (phoneController.text.split(' ').length >
                                      9 &&
                                  phoneController.text.split(' ').length < 11) {
                                showDialogMessage(context,
                                    'Vui lòng nhập đúng định dạng số điện thoại',
                                    checkBack: false);
                              } else {
                                final phoneString =
                                    phoneController.text.replaceFirst("0", "+84");
                                try {
                                  showLoading(context);
                                  final result =
                                      await userRepository.register(phoneString);

                                  closeLoading(context);
                                  if ((result as Response).statusCode == 200) {
                                    NavigatorManager.push(
                                        context,
                                        OtpPage(
                                          phone: phoneString,
                                        ));
                                  }
                                } catch (error) {
                                  closeLoading(context);
                                  showDialogMessage(context,
                                      "Đã có sự cố xảy ra vui lòng thử lại",
                                      checkBack: false);
                                }
                              }
                            },
                          );
                        }),
                    40.spaceHeight,
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: FontSize.fontSize_16,
                            fontWeight: FontWeight.w400,
                            color: FontColor.colorFFFFFF,
                          ),
                          children: [
                            TextSpan(
                                text: Translate.of(context).dont_have_an_account),
                            TextSpan(
                                text:
                                    '  ${Translate.of(context).sign_in.toUpperCase()}'),
                          ],
                        ),
                      ),
                    ),
                    20.spaceHeight,
                    SizedBox(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<LoginGoogleCubit, LoginGoogleState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                await context
                                    .read<LoginGoogleCubit>()
                                    .signInWithGoogle();
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AppHome()));
                                // ignore: use_build_context_synchronously
                              },
                              child: CImage(
                                assetsPath: Assets.icGoogle,
                                height: 24,
                                width: 24,
                                color: FontColor.bgcolorFFFFFF,
                              ),
                            );
                          },
                        ),
                        20.spaceWidth,
                        CImage(
                          assetsPath: Assets.icFb,
                          height: 24,
                          width: 24,
                          color: FontColor.bgcolorFFFFFF,
                        ),
                        20.spaceWidth,
                        CImage(
                          assetsPath: Assets.icApple,
                          height: 24,
                          width: 24,
                          color: FontColor.bgcolorFFFFFF,
                        ),
                      ],
                      )
                    )
                  ],
                ),
              ),
            ],
        ),
      ),
      //),
    );
  }
}
