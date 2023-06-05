part of 'list_card_cubit.dart';

@immutable
abstract class ListCardState {}

class ListCardInitial extends ListCardState {}

class ListCardLoading extends ListCardState {}

class ListCardSuccess extends ListCardState {
  final totalPrice;
  final data;

  ListCardSuccess(this.totalPrice,this.data);
}

class ListCardFailure extends ListCardState {
  final message;

  ListCardFailure(this.message);
}
