
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/generated/l10n.dart';
import 'package:shop_cake/src/app_home.dart';
import 'package:shop_cake/src/home_page/ui/home_page.dart';
import 'package:shop_cake/src/login/bloc/authentication_cubit.dart';
import 'package:shop_cake/src/login/bloc/login_google_cubit.dart';
import 'package:shop_cake/src/login/repository/user_repository.dart';
import 'package:shop_cake/src/login/ui/register.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/c_button.dart';
import 'package:shop_cake/widgets/c_container.dart';
import 'package:shop_cake/widgets/c_image.dart';
import 'package:shop_cake/widgets/c_text.dart';
import 'package:shop_cake/widgets/c_textformfield.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class Login extends StatefulWidget {
  final AuthenticationStatus? openLogin;

  const Login({Key? key, this.openLogin}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _authenticationCubit = AuthenticationCubit();
  final userRepository = UserRepositoryImpl();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late bool effectLoading;

  @override
  void initState() {
    effectLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginGoogleCubit(),
      child: Scaffold(
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
                      text: "Chào mừng trở lại",
                      textColor: FontColor.colorFFFFFF,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.fontSize_24,
                    ),
                    20.spaceHeight,
                    CText(
                      text: "Đăng nhập để tiếp tục",
                      textColor: FontColor.colorFFFFFF,
                      fontSize: FontSize.fontSize_16,
                    ),
                    50.spaceHeight,
                    CTextFormField(
                      backgroundColor: FontColor.colorText231F20.withOpacity(0.8),
                      hintText: 'Tên đăng nhập',
                      controller: usernameController,
                      onComplete: () {
                        //FocusManager.instance.primaryFocus?.dispose();
                      },
                      contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 24),
                    ),
                    20.spaceHeight,
                    CTextFormField(
                      obscureText: true,
                      backgroundColor: FontColor.colorText231F20.withOpacity(0.8),
                      hintText: 'Mật khẩu',
                      controller: passwordController,
                      onComplete: () {
                        //FocusManager.instance.primaryFocus?.dispose();
                      },
                      contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 24),
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
                            fontSize: FontSize.fontSize_16,
                            fontWeight: FontWeight.w600,
                            fontColor: FontColor.colorFFFFFF,
                            radius: 8,
                            checkLoading: effectLoading,
                            onPressed: () async {
                              // _authenticationCubit.login(emailController.text, pwdController.text, context);
                              if (usernameController.text.split(' ').isEmpty ) {
                                showDialogMessage(context, 'Vui lòng nhập số điện thoại', checkBack: false);
                              } else if (usernameController.text.isEmpty) {
                                showDialogMessage(context, 'Vui lòng nhập số điện thoại', checkBack: false);
                              }
                              if (passwordController.text.isEmpty) {
                                showDialogMessage(context, 'Vui lòng nhập mật khẩu', checkBack: false);
                              }
                              // else if (usernameController.text.split(' ').length > 9 && usernameController.text.split(' ').length < 11) {
                              //   showDialogMessage(context, 'Vui lòng nhập đúng định dạng số điện thoại', checkBack: false);
                              // }
                              else {
                                final usernameString = usernameController.text;
                                final passwordString = passwordController.text;
                                try {
                                  showLoading(context);
                                  final result = await userRepository.login(usernameString, passwordString);

                                  closeLoading(context);
                                  if ((result as Response).statusCode == 200) {
                                    // ignore: use_build_context_synchronously
                                    NavigatorManager.push(
                                        context,
                                        HomePage(
                                          openLogin: widget.openLogin,
                                        ));
                                  }
                                } catch (error) {
                                  closeLoading(context);
                                  showDialogMessage(context, "Tài khoản của bạn chưa được đăng ký", checkBack: false);
                                }
                              }
                            },
                          );
                        }),
                    40.spaceHeight,
                    GestureDetector(
                      onTap: () {
                        NavigatorManager.push(context, const Register());
                      },
                      child: Center(
                        child: Text(
                          "Tạo tài khoản",
                          style: TextStyle(
                            fontSize: FontSize.fontSize_16,
                            color: FontColor.colorFFFFFF,
                          ),
                        ),
                      ),
                    ),
                    20.spaceHeight,
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: FontSize.fontSize_16,
                            fontWeight: FontWeight.w400,
                            color: FontColor.colorFFFFFF,
                          ),
                          children: [
                            TextSpan(text: Translate.of(context).dont_have_an_account),
                            TextSpan(text: '  ${Translate.of(context).sign_up.toUpperCase()}'),
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
                                await context.read<LoginGoogleCubit>().signInWithGoogle();
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AppHome())
                                );
                              },
                              child:  CImage(
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
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
        //),
      ),
    );
  }
}
