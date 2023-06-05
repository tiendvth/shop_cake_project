part of 'state_order_cubit.dart';

@immutable
abstract class StateOrderState {}

class StateOrderInitial extends StateOrderState {}

class StateOrderLoading extends StateOrderState {
  final states;
  final statesString;

  StateOrderLoading(this.states, this.statesString);
}