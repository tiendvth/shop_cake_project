part of 'profile_cubit.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
