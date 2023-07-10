part of 'get_address_cubit.dart';

@immutable
abstract class GetAddressState {}

class GetAddressInitial extends GetAddressState {}
class GetAddressLoading extends GetAddressState {}
class GetAddressSuccess extends GetAddressState {
  final List<Result>? address;
  GetAddressSuccess(this.address);
}
class GetAddressFailure extends GetAddressState {
  final String error;
  GetAddressFailure(this.error);
}
