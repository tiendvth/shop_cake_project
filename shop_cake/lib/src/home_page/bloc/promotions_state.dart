part of 'promotions_cubit.dart';

@immutable
abstract class PromotionsState {}

class PromotionsInitial extends PromotionsState {

}

class PromotionsLoading extends PromotionsState {}

class PromotionsSuccess extends PromotionsState {
  final data;
  PromotionsSuccess(this.data);
}

class PromotionsFailure extends PromotionsState {
  final message;
  PromotionsFailure(this.message);
}