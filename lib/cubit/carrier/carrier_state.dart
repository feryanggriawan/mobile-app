part of 'carrier_cubit.dart';

abstract class CarrierState extends Equatable {
  const CarrierState();
}

class CarrierInitial extends CarrierState {
  @override
  List<Object> get props => [];
}

class CarriersLoaded extends CarrierState {
  final List<Carrier> carriers;

  CarriersLoaded(this.carriers);

  @override
  List<Object> get props => [carriers];
}

class CarriersLoadingFailed extends CarrierState {
  final String message;

  CarriersLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

