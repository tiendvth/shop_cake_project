import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';

import '../../../network/network_manager.dart';
import '../repository/repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {

  final ListFoodRepository _foodRepository =
  ListFoodRepositoryImpl(apiProvider);

  CategoryCubit() : super(CategoryInitial());

  get search => null;

  Future<void> getCategory() async{

    try {
      emit(CategoryLoading());
      var data = await _foodRepository.listCategory(search);
      if (data != null){
        emit(CategorySuccess(data['data']));
      } else {
        emit(CategoryError('Backend error 403'));
      }
    } catch (onError) {
      final status = (onError as DioError).response?.statusCode;
      if (status == 403) {
        emit(CategoryError('Backend error 403'));
      } else {
        emit(CategoryError((onError as DioError).message));
      }
    }
  }

}
