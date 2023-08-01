part of 'list_food_cubit.dart';

@immutable
abstract class ListFoodState {}

class ListFoodInitial extends ListFoodState {}

class ListFoodLoading extends ListFoodState {}

class ListFoodSuccess extends ListFoodState {
  final data;
  final discount;
  ListFoodSuccess(this.data, this.discount);
}

class ListFoodFailure extends ListFoodState {
  final message;
  ListFoodFailure(this.message);
}
