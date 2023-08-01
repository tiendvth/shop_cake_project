import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/home_page/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // final HomeRepository _homeRepository;

  HomeCubit() : super(HomeInitial()) {
    emit(HomeInitial());
  }

  final HomeRepository _homeRepository = HomeRepositoryImpl(apiProvider);

  Future<void> getAllPromotions(search, priceFrom, priceTo) async {
    try {
      emit(HomeLoading());
      final data = await _homeRepository.getAll(search, priceFrom, priceTo);
      emit(HomeLoaded(data));
    } on DioError {
      emit(HomeFailure("Couldn't fetch Bđs. Is the device online?"));
    }
  }
}
