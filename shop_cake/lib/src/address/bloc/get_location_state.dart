part of 'get_location_cubit.dart';

@immutable
abstract class GetLocationState {}

class GetLocationInitial extends GetLocationState {}
class GetLocationLoading extends GetLocationState {}
class GetLocationSuccess extends GetLocationState {
  final List<Locations>? locations;
  GetLocationSuccess(this.locations);
}
class GetLocationFailed extends GetLocationState {
  final String error;
  GetLocationFailed(this.error);
}
