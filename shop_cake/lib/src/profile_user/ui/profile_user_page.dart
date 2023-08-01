import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/Menu/components/label.dart';
import 'package:shop_cake/src/profile_user/bloc/profile_user_cubit.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';
import 'package:shop_cake/src/profile_user/ui/update_profile_page.dart';

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
      create: (context) => _profileUserCubit,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: kMainWhiteColor,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: kBgMenu,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          "Thông tin cá nhân",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: kMainDarkColor,
            ),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ProfileUserCubit, ProfileUserState>(
                builder: (context, state) {
                  if (state is ProfileUserSuccess) {
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Thông tin cá nhân',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kF2F4B4E,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProfilePage(
                                          data: state.data,
                                        ),
                                      ),
                                    );
                                    // Navigator.pushNamed(
                                    //     context, Routes.editProfile);
                                  },
                                  child: Image.asset(
                                    Assets.icEdit,
                                    height: 24,
                                    width: 24,
                                    color: kF2F4B4E,),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CLabel(
                              image: Assets.icName,
                              title:
                                  '${state.data['fullName'] ?? state.data['username'] ?? 'Chưa cập nhật'}',
                              // title: '0123456789',
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
                              image: Assets.icCall,
                              title:
                                  '${state.data['telephone'] ?? 'Chưa cập nhật'}',
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
                              image: Assets.icEmail,
                              title: '${state.data['email'] ?? ''}',
                              // title: 'tiendv@gmail.com',
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
                              image: Assets.icAddress,
                              title:
                                  '${state.data['address'] ?? 'Chưa cập nhật'}',
                              // title: 'Phố Đông Tác, Phường Kim Liên, Quận Đống Đa, Hà Nội',
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
                  } else {
                    print('getUser : ${state.toString()}');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
