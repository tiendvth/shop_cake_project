import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_cake/src/list_food/model/price_filter.dart';
import 'package:shop_cake/src/list_food/repository/price_filter_repository.dart';

part 'list_price_filter_state.dart';

class ListPriceFilterCubit extends Cubit<ListPriceFilterState> {
  final PriceFilterRepository priceFilterRepository = PriceFilterRepositoryImpl();
  ListPriceFilterCubit() : super(ListPriceFilterInitial());

  Future<void> listPriceFilter() async {
    emit(ListPriceFilterLoading());
    try {
      final data = await priceFilterRepository.lisPriceFilter();
      if (data != null && data.isNotEmpty) {
        emit(ListPriceFilterSuccess(data));
      } else {
        emit(ListPriceFilterFailure(''));
      }
    } catch (exception) {
      emit(ListPriceFilterFailure(exception.toString()));
    }
  }
}
