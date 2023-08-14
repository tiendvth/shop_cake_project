import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/Menu/components/label.dart';
import 'package:shop_cake/src/Menu/components/user_avatar.dart';
import 'package:shop_cake/src/address/ui/address_page.dart';
import 'package:shop_cake/src/contact_Info/ui/contact_Info_page.dart';
import 'package:shop_cake/src/favourite/ui/favourite_screen.dart';
import 'package:shop_cake/src/my_order/ui/my_order_page.dart';
import 'package:shop_cake/src/payment/ui/payment_methods_page.dart';
import 'package:shop_cake/src/profile_user/bloc/profile_user_cubit.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';
import 'package:shop_cake/src/profile_user/ui/profile_user_page.dart';
import 'package:shop_cake/widgets/c_image.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final getProfile = ProfileUserCubit(ProfileUserRepositoryImpl(apiProvider));

  @override
  void initState() {
    super.initState();
    getProfile.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              ProfileUserCubit(ProfileUserRepositoryImpl(apiProvider)),
        ),
        BlocProvider(
          create: (context) => getProfile,
        ),
      ],
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
                                    fontSize: 18,
                                    color: kMainDarkColor),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const CImage(
                              assetsPath: Assets.icNotification,
                              height: 24,
                              width: 24,
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
                    BlocBuilder<ProfileUserCubit, ProfileUserState>(
                      builder: (context, stateUser) {
                        if (stateUser is ProfileUserLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (stateUser is ProfileUserSuccess) {
                          return UserAvatar(
                            name: stateUser.data['fullName'],
                            address: stateUser.data['address'],
                            phone: stateUser.data['telephone'],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        CLabel(
                          title: "Tài khoản",
                          image: Assets.icUser,
                          onTab: () {
                            NavigatorManager.push(
                              context,
                               ProfileUserPage(
                                onPopCallback: () {
                                  getProfile.getProfile();
                                },
                              ),
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
                         CLabel(
                          title: "Yêu thích",
                          image: Assets.icLike,
                          onTab: () {
                            NavigatorManager.push(
                              context,
                              const FavouriteScreen(),
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
                          title: "Thanh toán",
                          image: Assets.icPaymentCard,
                          onTab: () {
                            NavigatorManager.push(
                              context,
                              const PaymentMethodPage(),
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
                          title: "Địa chỉ",
                          image: Assets.icLocation,
                          onTab: () {
                            NavigatorManager.push(
                              context,
                              const AddressPage(),
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
                          title: "Liên hệ",
                          image: Assets.icCall,
                          onTab: () {
                            NavigatorManager.push(
                              context,
                              const ContactInfoPage(),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
