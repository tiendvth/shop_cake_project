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
   double totalPrice = 0;

  ListCardCubit(this._cartRepository) : super(ListCardInitial());

  Future<void> getListCart() async {
    try {
      emit(ListCardLoading());
      final data = await _cartRepository.listCart();
      if (data != null && data["code"] == 204) {
        // print('ListCardLoading $totalPrice');
        datas.clear();
        emit(ListCardSuccess(data, datas, totalPrice = 0));
      } else {
        datas.clear();
        totalPrice = data['data']['result'].fold(
            0, (previousValue, element) => previousValue + element['priceCake'] * element['quantityShoppingCartTmt']);
        datas.addAll(data['data']['result'],);
        print('ListCardSuccess $totalPrice');
        emit(ListCardSuccess(data['data']['result'], datas, totalPrice));
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
      if (data['data']['result'] != null) {
        // totalPrice = data['data']['result'].fold(
        //     0, (previousValue, element) => previousValue + element['priceCake'] * element['quantityShoppingCartTmt']);
        datas.addAll(data['data']['result']);
        emit(ListCardSuccess(data['data']['result'], datas, totalPrice));
      }
      // emit(ListCardSuccess(data['totalPrice'],datas));
      emit(ListCardSuccess(data['data']['result'], datas, totalPrice));
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
      emit(ListCardSuccess(data['data']['result'], datas, totalPrice));
      closeLoading(context);
    } on DioError {
      closeLoading(context);
      emit(ListCardFailure("Is the device online?"));
    }
  }
}
