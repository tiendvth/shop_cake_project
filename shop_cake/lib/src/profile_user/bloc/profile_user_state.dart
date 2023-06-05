part of 'profile_user_cubit.dart';

@immutable
abstract class ProfileUserState {}

class ProfileUserInitial extends ProfileUserState {}

class ProfileUserLoading extends ProfileUserState {}

class ProfileUserSuccess extends ProfileUserState {
  final data;
  ProfileUserSuccess(this.data);
}

class ProfileUserFailure extends ProfileUserState {
  final message;
  ProfileUserFailure(this.message);
}
