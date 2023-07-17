part of 'list_price_filter_cubit.dart';

@immutable
abstract class ListPriceFilterState {}

class ListPriceFilterInitial extends ListPriceFilterState {}
class ListPriceFilterLoading extends ListPriceFilterState {}
class ListPriceFilterSuccess extends ListPriceFilterState {
  final List<FilterPrice> data;
  ListPriceFilterSuccess(this.data);
}
class ListPriceFilterFailure extends ListPriceFilterState {
  final String message;
  ListPriceFilterFailure(this.message);
}
