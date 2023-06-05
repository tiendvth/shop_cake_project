import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/font_size/font_size.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/profile_user/bloc/profile_user_cubit.dart';
import 'package:shop_cake/src/profile_user/common/label.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';

class ProfileUserPage extends StatelessWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: FontColor.colorFF3366,
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            ProfileUserCubit(ProfileUserRepositoryImpl(apiProvider)),
        child: BlocBuilder<ProfileUserCubit, ProfileUserState>(
          builder: (context, state) {
            if (state is ProfileUserSuccess) {
              return Container(
                padding: EdgeInsets.only(top: 20, left: 32, right: 32),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 84,
                                    width: 84,
                                    child: ClipOval(
                                        child: Image.network(
                                            'https://img.freepik.com/premium-vector/man-avatar-profile-round-icon_24640-14044.jpg?w=2000'))),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    '${state.data['firstName'] ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff231F20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Thông tin cá nhân',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff231F20),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Label(
                            image: 'assets/icon/ic_phone.png',
                            title: '${state.data['phone'] ?? '0123456789'}',
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xffF1F1F1),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Label(
                            image: 'assets/icon/ic_message.png',
                            title: '${state.data['email'] ?? ''}',
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xffF1F1F1),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Label(
                            image: 'assets/icon/ic_location.png',
                            title:
                                '${state.data['identityProvider'] ?? 'Metaway Holdings'}',
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xffF1F1F1),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<ProfileUserCubit>()
                            .removeDeviceToken();
                        context
                            .read<AuthenticationBloc>()
                            .add(AppLogoutEvent());
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: FontColor.colorEC222D,
                        ),
                        margin: EdgeInsets.only(bottom: 40),
                        child: Center(
                          child: Text("Logout",
                              style: TextStyle(
                                color: FontColor.colorFFFFFF,
                                fontSize: FontSize.fontSize_18,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
