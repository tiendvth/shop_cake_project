import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_my_order/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';

part 'detail_my_order_state.dart';

class DetailMyOrderCubit extends Cubit<DetailMyOrderState> {
  TextEditingController cenCelController =TextEditingController();
  final id;
  double totalPrice = 0;
  final _detailMyOrderRepositoryImpl =DetailMyOrderRepositoryImpl(apiProvider);
  DetailMyOrderCubit(this.id,) : super(DetailMyOrderInitial()){
    getDetailMyOrder();
  }

  Future<void> getDetailMyOrder() async{
    try {
      emit(DetailMyOrderLoading());
      final data = await _detailMyOrderRepositoryImpl.detailMyOrder(id);

      // emit(DetailMyOrderSuccess(data['data']['totalPrice'],data['data']['status'],data['data']['orderDetails']));
      totalPrice = data['data']['detailDtoList'].fold(
          0, (previousValue, element) => previousValue + element['price'] * element['quantity']);
      emit(DetailMyOrderSuccess(data['data']['detailDtoList'], totalPrice, data['data']['status']),);
    } on DioError {
      emit(DetailMyOrderFailure('$DioError'));
    }
  }

  callApiCanCel(BuildContext context) {
    _detailMyOrderRepositoryImpl.canCel(id, cenCelController.text,).then((value) {
      Navigator.pop(context);
      showToast('Hủy đơn thành công');
    },
    ).catchError((onError) {
      showDialogMessage(context, (onError as DioError).message, checkBack: false);
    });
  }

  callApiConfirm(BuildContext context) {
    _detailMyOrderRepositoryImpl.procedure(id).then((value) {
      Navigator.pop(context);
      showToast('Xác nhận đơn thành công',);
    },
    ).catchError((onError) {
      showDialogMessage(context, (onError as DioError).message, checkBack: false);
    });
  }
}
