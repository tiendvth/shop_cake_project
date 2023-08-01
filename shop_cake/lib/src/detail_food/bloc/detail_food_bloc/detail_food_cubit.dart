import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/detail_food/components/confirm_dialogs.dart';
import 'package:shop_cake/src/detail_food/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';

part 'detail_food_state.dart';

class DetailFoodCubit extends Cubit<DetailFoodState> {
  final id;
  var quantity = 1;
  final DetailFoodRepository _detailFoodRepository;

  DetailFoodCubit(this._detailFoodRepository, this.id)
      : super(DetailFoodInitial()) {
    getDetailFood();
  }

  Future<void> getDetailFood() async {
    try {
      emit(DetailFoodLoading());
      final data = await _detailFoodRepository.detailFood(id);
      emit(DetailFoodSuccess(data));
    } on DioError {
      emit(DetailFoodFailure("Couldn't fetch Bđs. Is the device online?"));
    }
  }

  addFoodToOrder(BuildContext context, foodId, price) {
    _detailFoodRepository.addFoodToOrder(foodId, price,quantity).then((value) {
      showDialogMessageConfirm(context, checkBack: false, const ConfirmDialog());
    }).catchError((onError) {
      showToast((onError as DioError).message);
    });
  }
}
