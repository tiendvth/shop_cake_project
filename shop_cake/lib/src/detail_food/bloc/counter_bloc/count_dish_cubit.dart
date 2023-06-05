import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_food/repository/repository.dart';

part 'count_dish_state.dart';

class CountDishCubit extends Cubit<CountDishState> {
  final creatnew = DetailFoodRepositoryImpl(apiProvider);
  int count_dish = 1;

  CountDishCubit() : super(CountDishInitial());

  addDish() {
    count_dish++;
    emit(CountDishCount(count:count_dish));
  }

  prisonDish() {
    if (count_dish > 1) {
      count_dish--;
      emit(CountDishPrison(count_dish.toString()));
    }
  }
  callApiCreateBooking(BuildContext context) {
    creatnew.creatNew(creatnew).then((value) {
      Navigator.pop(context);
    }).onError((error, stackTrace) {
    });
  }
}
