import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/badge_widget.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/Menu/components/label.dart';
import 'package:shop_cake/src/Menu/components/user_avatar.dart';
import 'package:shop_cake/src/my_order/ui/my_order_page.dart';
import 'package:shop_cake/src/profile_user/bloc/profile_user_cubit.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';
import 'package:shop_cake/src/profile_user/ui/profile_user_page.dart';
import 'package:shop_cake/widgets/c_image.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProfileUserCubit(ProfileUserRepositoryImpl(apiProvider)),
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 230,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: kBgMenu,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    SizedBox(
                      height: 56,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              "Menu",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: kMainDarkColor),
                              ),
                            ),
                          ),
                          Badge(
                            value: '3',
                            child: InkWell(
                              onTap: () {},
                              child: const CImage(
                                assetsPath: Assets.icNotification,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const UserAvatar(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CLabel(
                        title: "Tài khoản",
                        image: Assets.icUser,
                        onTab: () {
                          NavigatorManager.push(
                            context,
                            const ProfileUserPage(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: kF2F4B4E,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                       CLabel(
                        title: "Đơn hàng",
                        image: Assets.icOrderMenu,
                        onTab: () {
                          NavigatorManager.push(
                            context,
                            const MyOrderPage(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: kF2F4B4E,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CLabel(
                        title: "Yêu thích",
                        image: Assets.icLike,
                        onTab: null,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: kF2F4B4E,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CLabel(
                        title: "Thanh toán",
                        image: Assets.icPaymentCard,
                        onTab: null,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: kF2F4B4E,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CLabel(
                        title: "Liên hệ",
                        image: Assets.icCall,
                        onTab: null,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: kF2F4B4E,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CLabel(
                        title: "Cài đặt",
                        image: Assets.icSetting,
                        onTab: null,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: kF2F4B4E,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<ProfileUserCubit, ProfileUserState>(
                        builder: (context, state) {
                          return CLabel(
                            title: "Đăng xuất",
                            image: Assets.icLogout,
                            onTab: () async {
                              // await context
                              //     .read<ProfileUserCubit>()
                              //     .removeDeviceToken();
                              // ignore: use_build_context_synchronously
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AppLogoutEvent());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
