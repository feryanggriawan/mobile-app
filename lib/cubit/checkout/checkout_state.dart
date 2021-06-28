part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutLoadingFailed extends CheckoutState {
  final String message;

  CheckoutLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
