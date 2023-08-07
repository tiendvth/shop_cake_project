import 'package:common/common.dart';
import 'package:shop_cake/src/address/address_request/address_request.dart';
import 'package:shop_cake/src/address/model/address_model.dart';
import 'package:shop_cake/src/address/repository/address_repository.dart';

class AddressImpl implements AddressRepository {
  final Dio _dio;

  AddressImpl(this._dio);

  @override
  Future<List<Result>> getAddressList() async {
    final addressRequest = AddressRequest(
      size: 10,
      page: 1,
      name: '',
    );
    try {
      final response = await _dio.post('/api/deliveryAddress/getAll', data: addressRequest);
      if (response.statusCode == 200) {
        final addressResponse = Address.fromJson(response.data);
        return addressResponse.data?.result ?? [];
      } else {
        throw Exception('Failed to load address');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> createAddress(String? name, String? phone, String? address) async {
    final addressRequest = AddressRequest(
      name: name,
      address: address,
      phone: phone,
    );
    try {
      final response = await _dio.post('/api/deliveryAddress/create', data: addressRequest);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create address');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> updateAddress(String? name, String? phone, String? address, int? id) async {
    final addressRequest = AddressRequest(
      name: name,
      address: address,
      phone: phone,
    );
    try {
      final response = await _dio.post('/api/deliveryAddress/update/$id', data: addressRequest);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create address');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> deleteAddress(int id) async {
    try {
      final response = await _dio.get('/api/deliveryAddress/delete/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete address');
      }
    } catch (e) {
      throw e;
    }
  }
}
