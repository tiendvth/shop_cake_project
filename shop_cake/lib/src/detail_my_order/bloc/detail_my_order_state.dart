part of 'detail_my_order_cubit.dart';

@immutable
abstract class DetailMyOrderState {}

class DetailMyOrderInitial extends DetailMyOrderState {}

class DetailMyOrderLoading extends DetailMyOrderState {}

class DetailMyOrderSuccess extends DetailMyOrderState {
  // final status;
  // final totalPrice;
  final data;
  // DetailMyOrderSuccess(this.totalPrice,this.status,this.data);
  DetailMyOrderSuccess(this.data);
}

class DetailMyOrderFailure extends DetailMyOrderState {
  final message;
  DetailMyOrderFailure(this.message);
}

