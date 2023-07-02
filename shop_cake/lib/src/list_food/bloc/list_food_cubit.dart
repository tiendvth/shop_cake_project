import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/list_food/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';

part 'list_food_state.dart';

class ListFoodCubit extends Cubit<ListFoodState> {
  final ListFoodRepository _foodRepository =
      ListFoodRepositoryImpl(apiProvider);
  TextEditingController searchController = TextEditingController();
  List cartCakeList = [];

  ListFoodCubit() : super(ListFoodInitial());

  Future<void> getListFood(search) async{
    try {
      emit(ListFoodLoading());
      var data = await _foodRepository.listFood(search);
      if (data != null){
        emit(ListFoodSuccess(data['data']));
      } else {
        emit(ListFoodFailure('Backend error 403'));
      }
    } catch (onError) {
      final status = (onError as DioError).response?.statusCode;
      if (status == 403) {
        emit(ListFoodFailure('Backend error 403'));
      } else {
        emit(ListFoodFailure((onError as DioError).message));
      }
    }

    // _foodRepository.listFood(searchController.text).then((value) {
    //   emit(ListFoodSuccess(value['data']['content']));
    // }).catchError((onError) {
    //   final status = (onError as DioError).response?.statusCode;
    //   if (status == 403) {
    //     emit(ListFoodFailure('Backend error 403'));
    //   } else {
    //     emit(ListFoodFailure((onError as DioError).message));
    //   }
    // });
  }

  addFoodToOrder(BuildContext context, {cakeId, quantity}) {
    cartCakeList.add({
      "cakeId": cakeId,
      "quantity": quantity,
    });
    _foodRepository.addFoodToOrder(cakeId, quantity).then((value) {
      showToast('Add to cart success');
    }).catchError((onError) {
      showToast((onError as DioError).message);
    });
  }
}
