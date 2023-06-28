part of 'detail_food_cubit.dart';

@immutable
abstract class DetailFoodState {
  get data => null;
}

class DetailFoodInitial extends DetailFoodState {}

class DetailFoodLoading extends DetailFoodState {}

class DetailFoodSuccess extends DetailFoodState {
  final data;

  DetailFoodSuccess(this.data);
}

class DetailFoodFailure extends DetailFoodState {
  final message;

  DetailFoodFailure(this.message);
}
