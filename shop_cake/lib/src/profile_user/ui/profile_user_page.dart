import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/Menu/components/label.dart';
import 'package:shop_cake/src/profile_user/bloc/profile_user_cubit.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';
import 'package:shop_cake/widgets/c_image.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  final ProfileUserCubit _profileUserCubit =
      ProfileUserCubit(ProfileUserRepositoryImpl(apiProvider));

  @override
  void initState() {
    super.initState();
    _profileUserCubit.getProfile();
  }
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
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: kBgMenu,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    Row(
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
                        const CImage(
                          assetsPath: Assets.icNotification,
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<ProfileUserCubit, ProfileUserState>(
                builder: (context, state) {
                  if (state is ProfileUserFailure) {
                    return Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 84,
                                        width: 84,
                                        child: ClipOval(
                                          child: Image.network(
                                              'https://img.freepik.com/premium-vector/man-avatar-profile-round-icon_24640-14044.jpg?w=2000'),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: ClipOval(
                                            child: Container(
                                              color: Colors.white,
                                              child: const Icon(
                                                Icons.camera_alt,
                                                size: 16,
                                                color: kF2F4B4E,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Thông tin cá nhân',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kF2F4B4E,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const CLabel(
                              image: Assets.icName,
                              // title: '${state.data['phone'] ?? '0123456789'}',
                              title: '0123456789',
                              color: true,
                              colorText: false,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Divider(
                              thickness: 0.1,
                              color: kF2F4B4E,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const CLabel(
                              image: Assets.icCall,
                              // title: '${state.data['phone'] ?? '0123456789'}',
                              title: '0123456789',
                              color: true,
                              colorText: false,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Divider(
                              thickness: 0.1,
                              color: kF2F4B4E,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const CLabel(
                              image: Assets.icEmail,
                              // title: '${state.data['email'] ?? ''}',
                              title: 'tiendv@gmail.com',
                              color: true,
                              colorText: false,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Divider(
                              thickness: 0.1,
                              color: kF2F4B4E,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const CLabel(
                              image: Assets.icAddress,
                              // title: '${state.data['address'] ?? ''}',
                              title: 'Phố Đông Tác, Phường Kim Liên, Quận Đống Đa, Hà Nội',
                              color: true,
                              colorText: false,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Divider(
                              thickness: 0.1,
                              color: kF2F4B4E,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            CLabel(
                              title: 'Xóa tài khoản',
                              onTab: () async {
                                await context
                                    .read<ProfileUserCubit>()
                                    .removeDeviceToken();
                                // ignore: use_build_context_synchronously
                                context
                                    .read<AuthenticationBloc>()
                                    .add(AppLogoutEvent());
                              },
                              image: Assets.icDelete,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
