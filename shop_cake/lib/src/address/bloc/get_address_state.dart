part of 'get_address_cubit.dart';

@immutable
abstract class GetAddressState {}

class GetAddressInitial extends GetAddressState {}
class GetAddressLoading extends GetAddressState {}
class GetAddressSuccess extends GetAddressState {
  final List<VietNamModel>? vietNamModel;
  GetAddressSuccess(this.vietNamModel);
}
class GetAddressFailure extends GetAddressState {
  final String error;
  GetAddressFailure(this.error);
}
