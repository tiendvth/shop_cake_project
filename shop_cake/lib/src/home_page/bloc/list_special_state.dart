part of 'list_special_cubit.dart';

@immutable
abstract class ListSpecialState {}

class ListSpecialInitial extends ListSpecialState {}
class ListSpecialLoading extends ListSpecialState {}
class ListSpecialSuccess extends ListSpecialState {
  final data;
  ListSpecialSuccess(this.data);
}
class ListSpecialFailure extends ListSpecialState {
  final String? message;
  ListSpecialFailure(this.message);
}
