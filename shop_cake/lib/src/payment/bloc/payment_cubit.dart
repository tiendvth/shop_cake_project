import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/payment/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  int? deliveryAddressId;
  String? note;
  String? reason;
  DateTime? deliveryDate;
  List? orderDetails;

  // TextEditingController noteController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final PaymentRepository _paymentRepository;
  final CartRepository _cartRepository;

  // final List<String> items = ['RESTAURANT', 'SHIP'];
  // String selectedValue = 'RESTAURANT';
  var datas = [];
  var totalPrice = 100000.0;
  var visibleShip = false;

  PaymentCubit(this._paymentRepository, this._cartRepository) : super(PaymentInitial());

  Future<void> getPayment() async {
    try {
      emit(PaymentLoading());
      final data = await _cartRepository.ListCart();
      datas.clear();
      datas.addAll(data['data']['result'] as List);
      // totalPrice = '${Validation.oCcy.format(data['data']['price'] ?? 0)}';
      // emit(PaymentSuccess(datas, totalPrice, selectedValue));
      // totalPrice = '${FormatPrice.formatStringVND(totalPrice)}';
      emit(PaymentSuccess(datas, totalPrice));
    } on DioError {
      emit(PaymentFailure("Is the device online?"));
    }
  }

  updateTypeShip() {
    // emit(PaymentSuccess(datas, totalPrice, selectedValue));
    emit(PaymentSuccess(datas, totalPrice));
  }

 Future<bool> callApiPayment(BuildContext context , String dateController, List orderDetails, String note, String reason, int deliveryAddressId) {
   if (dateController.isEmpty) {
     showDialogMessage(context, 'Vui lòng nhập ngày giao hàng', checkBack: false);
     return Future.value(false);
   }
    showLoading(context);
   final orderDetails = datas.map((e) => {
     "cakeId": e['cakeId'],
     "quantity": e['quantityShoppingCartTmt'],
     "price": e['priceCake'],
    }).toList();
    try {
      _paymentRepository.Payment(
        deliveryDate: dateController,
        orderDetails: orderDetails,
        note: note,
        reason: reason,
        deliveryAddressId: deliveryAddressId,
      );
      closeLoading(context);
      showToast('Đặt hàng thành công');
      return Future.value(true);
    } on DioError catch (e) {
      closeLoading(context);
      showToast(e.toString());
      return Future.value(false);
    }
    // if (dateController.isEmpty) {
    //   showDialogMessage(context, 'Vui lòng nhập ngày giao hàng', checkBack: false);
    //   return;
    // }
    // if (selectedValue == "SHIP") {
    //   if (nameController.text.isEmpty) {
    //     showDialogMessage(context, 'Vui lòng nhập tên', checkBack: false);
    //     return;
    //   }
    //   if (phoneController.text.isEmpty) {
    //     showDialogMessage(context, 'Vui lòng nhập số điện thoại',
    //         checkBack: false);
    //     return;
    //   }
    //   if (addressController.text.isEmpty) {
    //     showDialogMessage(context, 'Vui lòng nhập địa chỉ', checkBack: false);
    //     return;
    //   }
    // }
    _paymentRepository.Payment(
      // noteController.text,
      // addressController.text,
      // nameController.text,
      // phoneController.text,
      // selectedValue,
      deliveryAddressId: deliveryAddressId,
      note: note,
      reason: reason,
      deliveryDate: dateController,
      orderDetails: orderDetails,

    ).then((value) {
      Navigator.pop(context);
      showToast("Đặt đơn thành công");
    }).catchError((onError) {
      showDialogMessage(context, (onError as DioError).message,
          checkBack: false);
    });
  }
}
