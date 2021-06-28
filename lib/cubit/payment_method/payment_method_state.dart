part of 'payment_method_cubit.dart';

abstract class PaymentMethodState extends Equatable {
  const PaymentMethodState();
}

class PaymentMethodInitial extends PaymentMethodState {
  @override
  List<Object> get props => [];
}

class PaymentMethodLoaded extends PaymentMethodState {
  final List<PaymentMethod> paymentMethods;

  PaymentMethodLoaded(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

class PaymentMethodLoadingFailed extends PaymentMethodState {
  final String message;

  PaymentMethodLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
