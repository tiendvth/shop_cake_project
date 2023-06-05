part of 'my_order_cubit.dart';

@immutable
abstract class MyOrderState {}

class MyOrderInitial extends MyOrderState {}

class MyOrderLoading extends MyOrderState {}

class MyOrderSuccess extends MyOrderState {
  final data;
  final typeShip;
  MyOrderSuccess(this.data,this.typeShip);
}

class MyOrderFailure extends MyOrderState {
  final message;
  MyOrderFailure(this.message);
}
