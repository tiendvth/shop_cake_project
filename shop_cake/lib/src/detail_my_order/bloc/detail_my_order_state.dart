part of 'detail_my_order_cubit.dart';

@immutable
abstract class DetailMyOrderState {}

class DetailMyOrderInitial extends DetailMyOrderState {}

class DetailMyOrderLoading extends DetailMyOrderState {}

class DetailMyOrderSuccess extends DetailMyOrderState {
  // final status;
  final totalPrice;
  final data;
  final status;
  // DetailMyOrderSuccess(this.totalPrice,this.status,this.data);
  DetailMyOrderSuccess(this.data, this.totalPrice, this.status);
}

class DetailMyOrderFailure extends DetailMyOrderState {
  final message;
  DetailMyOrderFailure(this.message);
}

