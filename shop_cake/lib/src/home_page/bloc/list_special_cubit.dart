import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/home_page/repository/home_repository.dart';

part 'list_special_state.dart';

class ListSpecialCubit extends Cubit<ListSpecialState> {
  ListSpecialCubit() : super(ListSpecialInitial());
  final HomeRepository _homeRepository = HomeRepositoryImpl(apiProvider);

  Future<void> getBySpecial() async {
    try {
      emit(ListSpecialLoading());
      final data = await _homeRepository.getBySpecial();
      emit(ListSpecialSuccess(data));
    } on DioError {
      emit(ListSpecialFailure("Couldn't fetch Bđs. Is the device online?"));
    }
  }
}
