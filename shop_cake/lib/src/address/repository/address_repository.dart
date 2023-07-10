
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/address/model/address_model.dart';
import 'package:shop_cake/src/address/provider/address_provider.dart';

 abstract class AddressRepository {
  final AddressImpl _addressProvider = AddressImpl(apiProvider);

  Future<List<Result>> getAddressList() async {
    return await _addressProvider.getAddressList();
  }

  Future<bool> createAddress(String? name, String? phone, String? address) async {
    return await _addressProvider.createAddress(
      name,
      phone,
      address,
    );
  }

  Future<bool> updateAddress(Result address) async {
    return await _addressProvider.updateAddress(address);
  }

  Future<bool> deleteAddress(int id) async {
    return await _addressProvider.deleteAddress(id);
  }
}
