part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final data;
  final totalPrice;
  final typeShip;

  PaymentSuccess(this.data,this.totalPrice, this.typeShip);
}

class PaymentFailure extends PaymentState {
  final message;

  PaymentFailure(this.message);

  // get data => null;
}
