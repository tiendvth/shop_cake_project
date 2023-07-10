part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final datas;
  final double totalPrice;
  // final typeShip;

  PaymentSuccess(this.datas,this.totalPrice);
}

class PaymentFailure extends PaymentState {
  final message;

  PaymentFailure(this.message);
}
