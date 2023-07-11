import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/utils/utils.dart';

part 'list_card_state.dart';

class ListCardCubit extends Cubit<ListCardState> {
  final List datas = [];
  final CartRepository _cartRepository;

  ListCardCubit(this._cartRepository) : super(ListCardInitial());

  Future<void> getListCart() async {
    try {
      emit(ListCardLoading());
      final data = await _cartRepository.ListCart();
      if (data != null && data["code"] == 204) {
        emit(ListCardSuccess(data, datas));
      } else {
        datas.clear();
        datas.addAll(data['data']['result']);
        emit(ListCardSuccess(data['data']['result'], datas));
      }
    } on DioError {
      emit(ListCardFailure("Is the device online?"));
    }
  }

  addFood(BuildContext context, foodId, quantity) async {
    showLoading(context);
    try {
      final data = await _cartRepository.updateFoodToCart(foodId, quantity);
      datas.clear();
      datas.addAll(data['data']['result']);
      // emit(ListCardSuccess(data['totalPrice'],datas));
      emit(ListCardSuccess(data['result'], datas));
      closeLoading(context);
    } on DioError {
      closeLoading(context);
      showToast('aaaa');
    }
  }

  removeFood(BuildContext context, foodId) async {
    showLoading(context);
    try {
      final data = await _cartRepository.removeFoodToCart(foodId);
      datas.clear();
      datas.addAll(data['data']['result']);
      emit(ListCardSuccess(data['data']['result'], datas));
      closeLoading(context);
    } on DioError {
      closeLoading(context);
      emit(ListCardFailure("Is the device online?"));
    }
  }
}
