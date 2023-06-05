import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/home_page/repository/home_repository.dart';

part 'home_state.dart';

class LoginCubit extends Cubit<HomeState> {
  LoginCubit() : super(HomeInitial()) {
    emit(HomeInitial());
  }

  final HomeRepository _homeRepository = HomeRepositoryImpl(apiProvider);
}
