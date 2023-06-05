import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/payment/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/validation/validation.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final PaymentRepository _paymentRepository;
  final List<String> items = ['RESTAURANT', 'SHIP'];
  String selectedValue = 'RESTAURANT';
  var datas = [];
  var totalPrice = '0';
  var visibleShip = false;

  PaymentCubit(this._paymentRepository) : super(PaymentInitial()) {
    getPayment();
  }

  Future<void> getPayment() async {
    try {
      emit(PaymentLoading());
      final data = await _paymentRepository.listCart();
      datas.clear();
      datas.addAll(data['data']['items'] as List);
      totalPrice = '${Validation.oCcy.format(data['data']['totalPrice'] ?? 0)}';
      emit(PaymentSuccess(datas, totalPrice, selectedValue));
    } on DioError {
      emit(PaymentFailure("Is the device online?"));
    }
  }

  updateTypeShip() {
    emit(PaymentSuccess(datas, totalPrice, selectedValue));
  }

  callApiPayment(BuildContext context) {
    if (selectedValue == "SHIP") {
      if (nameController.text.isEmpty) {
        showDialogMessage(context, 'Vui lòng nhập tên', checkBack: false);
        return;
      }
      if (phoneController.text.isEmpty) {
        showDialogMessage(context, 'Vui lòng nhập số điện thoại',
            checkBack: false);
        return;
      }
      if (addressController.text.isEmpty) {
        showDialogMessage(context, 'Vui lòng nhập địa chỉ', checkBack: false);
        return;
      }
    }
    _paymentRepository.Payment(
      noteController.text,
      addressController.text,
      nameController.text,
      phoneController.text,
      selectedValue,
    ).then((value) {
      Navigator.pop(context);
      showToast("Đặt đơn thành công");
    }).catchError((onError) {
      showDialogMessage(context, (onError as DioError).message,
          checkBack: false);
    });
  }
}
