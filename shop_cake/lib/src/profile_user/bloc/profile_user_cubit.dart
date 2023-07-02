import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/profile_user/repository/repository.dart';

part 'profile_user_state.dart';

class ProfileUserCubit extends Cubit<ProfileUserState> {
  final ProfileUserRepository _profileUserRepository;

  ProfileUserCubit(this._profileUserRepository) : super(ProfileUserInitial());

  Future<void> getProfile() async {
    try {
      emit(ProfileUserLoading());
      final data = await _profileUserRepository.profileUser();
      emit(ProfileUserSuccess(data));
    } on DioError {
      emit(ProfileUserFailure("Is the device online?"));
    }
  }

  Future<void> removeDeviceToken() async {
    try {
      await _profileUserRepository.removeDeviceToken(device_token);
    } on DioError {}
  }
}
