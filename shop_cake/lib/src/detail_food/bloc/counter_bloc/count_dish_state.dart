part of 'count_dish_cubit.dart';

@immutable
abstract class CountDishState {}

class CountDishInitial extends CountDishState {}

class CountDishCount extends CountDishState {
  int? count;
  CountDishCount({this.count});
}

class CountDishPrison extends CountDishState {
  String remove;
  CountDishPrison(this.remove);
}