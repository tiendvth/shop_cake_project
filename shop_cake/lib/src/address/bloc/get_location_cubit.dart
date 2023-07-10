import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/address/model/viet_nam_model.dart';
import 'package:shop_cake/src/address/repository/country_repository.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  final CountryRepository countryRepository = CountryRepository();
  GetLocationCubit() : super(GetLocationInitial());

  Future<void> loadLocationData() async {
    emit(GetLocationLoading());
    try {
      final locations = await countryRepository.getLocations();
      if (locations != null && locations.isNotEmpty) {
        emit(GetLocationSuccess(locations));
      } else {
        emit(GetLocationFailed(''));
      }
    } catch (exception) {
      emit(GetLocationFailed(exception.toString()));
    }
  }
}
