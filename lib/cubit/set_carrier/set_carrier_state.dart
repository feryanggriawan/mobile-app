part of 'set_carrier_cubit.dart';

abstract class SetCarrierState extends Equatable {
  const SetCarrierState();
}

class SetCarrierInitial extends SetCarrierState {
  @override
  List<Object> get props => [];
}

class SetCarrierLoaded extends SetCarrierState {
  @override
  List<Object> get props => [];
}

class SetCarrierLoadingFailed extends SetCarrierState {
  final String message;

  SetCarrierLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
