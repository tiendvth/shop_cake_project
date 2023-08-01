part of 'home_cubit.dart';

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
  final data;
  HomeLoaded(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
  // HomeFailure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
