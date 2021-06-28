part of 'set_delivery_address_cubit.dart';

abstract class SetDeliveryAddressState extends Equatable {
  const SetDeliveryAddressState();
}

class SetDeliveryAddressInitial extends SetDeliveryAddressState {
  @override
  List<Object> get props => [];
}


class SetDeliveryAddressLoaded extends SetDeliveryAddressState {
  final DeliveryAddress deliveryAddress;

  SetDeliveryAddressLoaded(this.deliveryAddress);

  @override
  List<Object> get props => [deliveryAddress];
}

class SetDeliveryAddressLoadingFailed extends SetDeliveryAddressState {
  final String message;

  SetDeliveryAddressLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
