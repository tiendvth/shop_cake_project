import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/home_page/repository/home_repository.dart';

part 'list_category_detail_state.dart';

class ListCategoryDetailCubit extends Cubit<ListCategoryDetailState> {
  ListCategoryDetailCubit() : super(ListCategoryDetailInitial());
  final HomeRepository _homeRepository = HomeRepositoryImpl(apiProvider);

  Future<void> listCategoryDetail(id) async {
    try {
      emit(ListCategoryDetailLoading());
      final data = await _homeRepository.getByCategory(id: id);
      if (data != null) {
        emit(ListCategoryDetailSuccess(data));
      } else {
        emit(ListCategoryDetailFailure('Có lỗi xảy ra vui lòng thử lại.'));
      }
    } catch (e) {
      emit(ListCategoryDetailFailure('Có lỗi xảy ra vui lòng thử lại.'));
    }
  }
}
