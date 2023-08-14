import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/favourite/repository/favourite_repository.dart';
import 'package:shop_cake/src/favourite/repository_impl/favourite_repository_impl.dart';
import 'package:shop_cake/utils/utils.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final FavouriteRepository _favouriteRepository =
      FavouriteRepoImpl(apiProvider);
  Future<void> getFavourite() async {
    try {
      emit(FavouriteLoading());
      final data = await _favouriteRepository.getFavourite();
      emit(FavouriteSuccess(data));
    } catch (onError) {
      emit(FavouriteFailure((onError as DioError).message));
    }
  }
  Future<void> addFavourite({id}) async {
    try {
      emit(FavouriteLoading());
      final data = await _favouriteRepository.addFavourite(id);
      emit(FavouriteSuccess(data));
      showToast("Đã thêm vào danh sách yêu thích");
    } catch (onError) {
      emit(FavouriteFailure((onError as DioError).message));
    }
  }
  Future<void> removeFavourite({id}) async {
    try {
      emit(FavouriteLoading());
      final data = await _favouriteRepository.deleteFavourite(id);
      emit(FavouriteSuccess(data));
      showToast("Đã xóa khỏi danh sách yêu thích");
    } catch (onError) {
      emit(FavouriteFailure((onError as DioError).message));
    }
  }
}
