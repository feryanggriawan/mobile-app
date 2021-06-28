part of 'set_payment_method_cubit.dart';

abstract class SetPaymentMethodState extends Equatable {
  const SetPaymentMethodState();
}

class SetPaymentMethodInitial extends SetPaymentMethodState {
  @override
  List<Object> get props => [];
}

class SetPaymentMethodLoaded extends SetPaymentMethodState {
  @override
  List<Object> get props => [];
}

class SetPaymentMethodLoadingFailed extends SetPaymentMethodState {
  final String message;

  SetPaymentMethodLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
