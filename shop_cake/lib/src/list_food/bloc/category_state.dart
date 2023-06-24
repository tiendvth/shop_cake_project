part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

//
class CategoryInitial extends CategoryState {}

//
class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final data;
  CategorySuccess(this.data);
}

class CategoryError extends CategoryState {
  final message;
  CategoryError(this.message);
}
