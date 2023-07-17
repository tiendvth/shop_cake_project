import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_custom_cubit_event.dart';
part 'order_custom_cubit_state.dart';

class OrderCustomCubitBloc extends Bloc<OrderCustomCubitEvent, OrderCustomCubitState> {
  OrderCustomCubitBloc() : super(OrderCustomCubitInitial()) {
    on<OrderCustomCubitEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
