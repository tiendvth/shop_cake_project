import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/login/repository/authen_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(LoginInitial()) {
    emit(LoginInitial());
  }

  final AuthenRepository _authenRespository = AuthenRepositoryImpl(apiProvider);

  Future<void> login(String otp, String phone, BuildContext context) async {
    if (state is LoadingState) {
      return;
    }
    emit(LoadingState());
    // var result = _authenRespository.login(username, password);
    // result.then((value) {
    //   context.read<AuthenticationBloc>().add(AppLoginSuccessEvent({
    //         "accessToken": value['accessToken'],
    //         "refreshToken": value['refreshToken']
    //       }));
    //   emit(LoginSuccess());
    // }, onError: (error) {
    //   emit(
    //     LoginFailure(
    //       message: (error as DioError).message.toString(),
    //     ),
    //   );
    // });
      context.read<AuthenticationBloc>().add(AppLoginSuccessEvent(const {
            "accessToken": 'accessToken',
            "refreshToken": 'refreshToken'
          }));
  }
}
