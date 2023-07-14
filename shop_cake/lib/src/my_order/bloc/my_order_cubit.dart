import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/my_order/repository/repository.dart';

part 'my_order_state.dart';

class MyOrderCubit extends Cubit<MyOrderState> {
  final MyOderRepository _myOderRepository;
  final List<String> items = ["PENDING", "PROCESSING","CANCEL", "DONE"];
  String selectedValue = "PENDING";

  MyOrderCubit(this._myOderRepository) : super(MyOrderInitial()) {
    getListOrder();
  }

  Future<void> getListOrder() async {
    _myOderRepository.listOrder(selectedValue).then(
      (value) {
        emit(MyOrderSuccess(value,selectedValue));
      },
    ).catchError(
      (onError) {
        final status = (onError as DioError).response?.statusCode;
        if (status == 403) {
          emit(MyOrderFailure('Backend error 403'));
        } else {
          emit(MyOrderFailure((onError).message));
        }
      },
    );
  }



}
