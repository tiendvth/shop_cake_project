import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/address/model/address_model.dart';
import 'package:shop_cake/src/address/provider/address_provider.dart';
import 'package:shop_cake/src/address/repository/address_repository.dart';

part 'get_address_state.dart';

class GetAddressCubit extends Cubit<GetAddressState> {
  final AddressRepository addressRepository = AddressImpl(apiProvider);

  GetAddressCubit() : super(GetAddressInitial());
  String? province;
  String? district;
  String? ward;
  String? detailAddress;

  Future<void> getAddress() async {
    emit(GetAddressLoading());
    try {
      final data = await addressRepository.getAddressList();
      if (data != null && data.isNotEmpty) {
        emit(GetAddressSuccess(data));
        // Tìm kiếm địa chỉ mặc định và cập nhật selectedDefaultAddressIndex
      } else if (data == null || data.isEmpty) {
        emit(GetAddressSuccess([]));
      } else {
        emit(GetAddressFailure(''));
      }
    } catch (exception) {
      emit(GetAddressFailure(exception.toString()));
    }
  }

  Future<void> createAddress(
      {String? name, String? phone, String? address}) async {
    emit(GetAddressLoading());
    try {
      final data = await addressRepository.createAddress(name, phone, address);
      if (data != null) {
        emit(GetAddressSuccess([]));
      } else {
        emit(GetAddressFailure(''));
      }
    } catch (exception) {
      emit(GetAddressFailure(exception.toString()));
    }
  }

  Future<void> updateAddress(
      {String? name, String? phone, String? address, int? id}) async {
    emit(GetAddressLoading());
    try {
      final data = await addressRepository.updateAddress(
          name: name, phone: phone, address: address, id: id);
      if (data) {
        emit(GetAddressSuccess([]));
      } else {
        emit(GetAddressFailure(''));
      }
    } catch (exception) {
      emit(GetAddressFailure(exception.toString()));
    }
  }

  Future<void> deleteAddress({int? id}) async {
    emit(GetAddressLoading());
    try {
      final data = await addressRepository.deleteAddress(id!);
      if (data) {
        emit(GetAddressSuccess([]));
      } else {
        emit(GetAddressFailure(''));
      }
    } catch (exception) {
      emit(GetAddressFailure(exception.toString()));
    }
  }

  Future<void> changeDefaultAddress({int? id}) async {
    emit(GetAddressLoading());
    try {
      final data = await addressRepository.changeDefaultAddress(id!);
      if (data) {
        emit(GetAddressSuccess([]));
      } else {
        emit(GetAddressFailure(''));
      }
    } catch (exception) {
      emit(GetAddressFailure(exception.toString()));
    }
  }
}
