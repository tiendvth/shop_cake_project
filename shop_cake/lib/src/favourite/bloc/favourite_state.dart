part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}
class FavouriteLoading extends FavouriteState {}
class FavouriteSuccess extends FavouriteState {
  final data;
  FavouriteSuccess(this.data);
}
class FavouriteFailure extends FavouriteState {
  final error;
  FavouriteFailure(this.error);
}
