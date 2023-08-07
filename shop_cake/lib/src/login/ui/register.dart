import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/generated/l10n.dart';
import 'package:shop_cake/src/login/bloc/authentication_cubit.dart';
import 'package:shop_cake/src/login/repository/user_repository.dart';
import 'package:shop_cake/src/login/ui/login.dart';
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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  late bool effectLoading;
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();

  // ignore: avoid_void_async
  bool validateEmail(String email) {
    // Regular expression pattern for email validation
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    // Sử dụng biểu thức chính quy để kiểm tra mật khẩu
    RegExp regex = RegExp(r'^(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(password);
  }

  @override
  void initState() {
    effectLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
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
              assetsPath: Assets.imgLogin,
              height: double.infinity,
              width: double.infinity,
            ),
            CContainer(
              height: double.infinity,
              width: double.infinity,
              backgroundColor: FontColor.colorText231F20.withOpacity(0.5),
              borderColor: FontColor.colorText231F20.withOpacity(0.8),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (AppBar().preferredSize.height + 56).spaceHeight,
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
                      backgroundColor:
                          FontColor.colorText231F20.withOpacity(0.8),
                      height: 60,
                      hintText: 'Tên đăng nhập',
                      hintStyle: GoogleFonts.roboto(
                        color: kMainLightGreyColor.withOpacity(0.8),
                        fontSize: 16,
                      ),
                      controller: usernameController,
                      onComplete: () {
                        //FocusManager.instance.primaryFocus?.dispose();
                      },
                      contentPadding: const EdgeInsets.only(top: 12, left: 24),
                    ),
                    16.spaceHeight,
                    Form(
                      key: _formKeyEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: () {
                        if (emailController.text.isNotEmpty &&
                            !validateEmail(emailController.text)) {
                          _formKeyEmail.currentState?.validate();
                        } else {
                          _formKeyEmail.currentState?.validate();
                        }
                      },
                      child: CTextFormField(
                        backgroundColor:
                            FontColor.colorText231F20.withOpacity(0.8),
                        height: 60,
                        hintText: 'Địa chỉ email',
                        hintStyle: GoogleFonts.roboto(
                          color: kMainLightGreyColor.withOpacity(0.8),
                          fontSize: 16,
                        ),
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        onComplete: () {
                          FocusManager.instance.primaryFocus?.dispose();
                        },
                        contentPadding:
                            const EdgeInsets.only(top: 12, left: 24),
                      ),
                    ),
                    16.spaceHeight,
                    Form(
                      key: _formKeyPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: () {
                        if (passwordController.text.isNotEmpty) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            _formKeyPassword.currentState?.validate();
                          } else {
                            _formKeyPassword.currentState?.validate();
                          }
                        }
                      },
                      child: CTextFormField(
                        obscureText: true,
                        backgroundColor:
                            FontColor.colorText231F20.withOpacity(0.8),
                        height: 60,
                        hintText: 'Mật khẩu',
                        hintStyle: GoogleFonts.roboto(
                          color: kMainLightGreyColor.withOpacity(0.8),
                          fontSize: 16,
                        ),
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        onComplete: () {
                          FocusManager.instance.primaryFocus?.dispose();
                        },
                        maxLines: 1,
                        contentPadding:
                            const EdgeInsets.only(top: 12, left: 24),
                      ),
                    ),
                    16.spaceHeight,
                    Form(
                      key: _formKeyConfirmPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: () {
                        if (confirmPasswordController.text.isNotEmpty) {
                          if (confirmPasswordController.text !=
                              passwordController.text) {
                            _formKeyConfirmPassword.currentState?.validate();
                          } else {
                            _formKeyConfirmPassword.currentState?.validate();
                          }
                        }
                      },
                      child: CTextFormField(
                        obscureText: true,
                        backgroundColor:
                            FontColor.colorText231F20.withOpacity(0.8),
                        height: 60,
                        hintText: 'Nhập lại mật khẩu',
                        hintStyle: GoogleFonts.roboto(
                          color: kMainLightGreyColor.withOpacity(0.8),
                          fontSize: 16,
                        ),
                        controller: confirmPasswordController,
                        textInputType: TextInputType.visiblePassword,
                        onComplete: () {
                          FocusManager.instance.primaryFocus?.dispose();
                        },
                        maxLines: 1,
                        contentPadding:
                            const EdgeInsets.only(top: 12, left: 24),
                      ),
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
                            bgColor: kMainRedColor.withOpacity(0.5),
                            title: 'Tiếp tục',
                            radius: 8,
                            fontSize: FontSize.fontSize_16,
                            fontWeight: FontWeight.w600,
                            fontColor: FontColor.colorFFFFFF,
                            borderColor: kMainRedColor.withOpacity(0.5),
                            checkLoading: effectLoading,
                            onPressed: () async {
                              if (usernameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                showDialogMessage(
                                    context, 'Vui lòng nhập đầy đủ thông tin',
                                    checkBack: false);
                              } else if (emailController.text.isNotEmpty &&
                                  !validateEmail(emailController.text)) {
                                showDialogMessage(context,
                                    'Vui lòng nhập đúng định dạng email',
                                    checkBack: false);
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                showDialogMessage(
                                    context, 'Mật khẩu không trùng khớp',
                                    checkBack: false);
                              } else {
                                final usernameString = usernameController.text;
                                final passwordString = passwordController.text;
                                final emailString = emailController.text;
                                try {
                                  showLoading(context);
                                  final result = await userRepository.register(
                                    usernameString,
                                    emailString,
                                    passwordString,
                                  );
                                  closeLoading(context);
                                  if ((result as Response).statusCode == 200) {
                                    // ignore: use_build_context_synchronously
                                    showDialogMessage(
                                        context, "Đăng ký thành công",
                                        checkBack: false);
                                    // ignore: use_build_context_synchronously
                                    NavigatorManager.push(
                                        context, const Login());
                                  }
                                } catch (error) {
                                  print('error: $error');
                                  closeLoading(context);
                                  showDialogMessage(context,
                                      "Đã có sự cố xảy ra vui lòng thử lại",
                                      checkBack: false);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // _authenticationCubit.login(emailController.text, pwdController.text, context);
                            //   if (usernameController.text.isEmpty) {
                            //     showDialogMessage(context, 'Vui lòng nhập tên đăng nhập', checkBack: false);
                            //   } else if (passwordController.text.isEmpty) {
                            //     showDialogMessage(context, 'Vui lòng nhập mật khẩu', checkBack: false);
                            //   }  if (emailController.text.isEmpty) {
                            //     if (emailController.text.isNotEmpty && !validateEmail(emailController.text)) {
                            //       showDialogMessage(context, 'Vui lòng nhập đúng định dạng email', checkBack: false);
                            //     } else {
                            //       showDialogMessage(context, 'Vui lòng nhập email', checkBack: false);
                            //     }
                            //   }  if (confirmPasswordController.text.isEmpty) {
                            //     showDialogMessage(context, 'Vui lòng nhập lại mật khẩu', checkBack: false);
                            //   }  if (passwordController.text != confirmPasswordController.text) {
                            //     showDialogMessage(context, 'Mật khẩu không trùng khớp', checkBack: false);
                            //   }
                            //   // else if (phoneController.text.split(' ').length >
                            //   //         9 &&
                            //   //     phoneController.text.split(' ').length < 11) {
                            //   //   showDialogMessage(context,
                            //   //       'Vui lòng nhập đúng định dạng số điện thoại',
                            //   //       checkBack: false);
                            //   // }
                            //   else {
                            //     final usernameString = usernameController.text;
                            //     final passwordString = passwordController.text;
                            //     final emailString = emailController.text;
                            //     try {
                            //       showLoading(context);
                            //       final result = await userRepository.register(usernameString,emailString,passwordString,);
                            //       closeLoading(context);
                            //       if ((result as Response).statusCode == 200) {
                            //         // ignore: use_build_context_synchronously
                            //         showDialogMessage(context, "Đăng ký thành công", checkBack: false);
                            //         // ignore: use_build_context_synchronously
                            //         NavigatorManager.push(context, const Login());
                            //       }
                            //     } catch (error) {
                            //       print('error: $error');
                            //       closeLoading(context);
                            //       showDialogMessage(context, "Đã có sự cố xảy ra vui lòng thử lại", checkBack: false);
                            //     }
                            //   }
                            // },
                          );
                        }),
                    40.spaceHeight,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: FontSize.fontSize_16,
                              fontWeight: FontWeight.w400,
                              color: FontColor.colorFFFFFF,
                            ),
                            children: [
                              TextSpan(
                                  text: Translate.of(context)
                                      .dont_have_an_account),
                              TextSpan(
                                  text:
                                      '  ${Translate.of(context).sign_in.toUpperCase()}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.spaceHeight,
                    SizedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // BlocBuilder<LoginGoogleCubit, LoginGoogleState>(
                        //   builder: (context, state) {
                        //     return InkWell(
                        //       onTap: () async {
                        //         await context
                        //             .read<LoginGoogleCubit>()
                        //             .signInWithGoogle();
                        //         // ignore: use_build_context_synchronously
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => AppHome()));
                        //         // ignore: use_build_context_synchronously
                        //       },
                        //       child: CImage(
                        //         assetsPath: Assets.icGoogle,
                        //         height: 24,
                        //         width: 24,
                        //         color: FontColor.bgcolorFFFFFF,
                        //       ),
                        //     );
                        //   },
                        // ),
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
            ),
          ],
        ),
      ),
      //),
    );
  }
}
