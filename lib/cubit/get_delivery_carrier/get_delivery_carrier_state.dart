part of 'get_delivery_carrier_cubit.dart';

abstract class GetDeliveryCarrierState extends Equatable {
  const GetDeliveryCarrierState();
}

class GetDeliveryCarrierInitial extends GetDeliveryCarrierState {
  @override
  List<Object> get props => [];
}


class GetDeliveryCarrierLoaded extends GetDeliveryCarrierState {
  final List<DeliveryCarrier> deliveryCarries;

  GetDeliveryCarrierLoaded(this.deliveryCarries);

  @override
  List<Object> get props => [deliveryCarries];
}

class GetDeliveryCarrierLoadingFailed extends GetDeliveryCarrierState {
  final String message;

  GetDeliveryCarrierLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
