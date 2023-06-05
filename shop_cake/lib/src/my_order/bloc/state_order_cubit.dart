import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'state_order_state.dart';

class StateOrderCubit extends Cubit<StateOrderState> {
  String dropdownvalue = 'Đã hoàn thành';

  StateOrderCubit() : super(StateOrderInitial());

  updateValue(value) {
    if (value.toString().contains("Chờ phản hồi")) {
      emit(StateOrderLoading(1, value.toString()));
    } else if (value.toString().contains("Đang xử lý")) {
      emit(StateOrderLoading(2, value.toString()));
    } else if (value.toString().contains("Đang giao")) {
      emit(StateOrderLoading(3, value.toString()));
    } else if (value.toString().contains("Đã hoàn thành")) {
      emit(StateOrderLoading(4, value.toString()));
    } else if (value.toString().contains("Đã hủy")) {
      emit(StateOrderLoading(5, value.toString()));
    }
  }
}
