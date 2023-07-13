part of 'list_card_cubit.dart';

@immutable
abstract class ListCardState {}

class ListCardInitial extends ListCardState {}

class ListCardLoading extends ListCardState {}

class ListCardSuccess extends ListCardState {
  final totalPrice;
  final data;
  final double total;

  ListCardSuccess(this.totalPrice,this.data, this.total);
}

class ListCardFailure extends ListCardState {
  final message;

  ListCardFailure(this.message);
}
