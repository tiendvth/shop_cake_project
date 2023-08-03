part of 'list_category_detail_cubit.dart';

@immutable
abstract class ListCategoryDetailState {}

class ListCategoryDetailInitial extends ListCategoryDetailState {}
class ListCategoryDetailLoading extends ListCategoryDetailState {}
class ListCategoryDetailSuccess extends ListCategoryDetailState {
  final data;
  ListCategoryDetailSuccess(this.data);
}
class ListCategoryDetailFailure extends ListCategoryDetailState {
  final String message;

  ListCategoryDetailFailure(this.message);
}
