import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/address/model/viet_nam_model.dart';
import 'package:shop_cake/src/address/repository/country_repository.dart';

part 'get_address_state.dart';

class GetAddressCubit extends Cubit<GetAddressState> {
  final CountryRepository _countryRepository = CountryRepository();
  GetAddressCubit() : super(GetAddressInitial());

  Future<void> loadLocationData() async {
    emit(GetAddressLoading());
    try {
     final vietNamModel = await _countryRepository.loadLocationData();
      emit(GetAddressSuccess(vietNamModel));
    } catch (e) {
      emit(GetAddressFailure(e.toString()));
    }
  }
}
