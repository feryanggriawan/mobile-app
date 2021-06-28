part of 'confirmation_payment_cubit.dart';

abstract class ConfirmationPaymentState extends Equatable {
  const ConfirmationPaymentState();
}

class ConfirmationPaymentInitial extends ConfirmationPaymentState {
  @override
  List<Object> get props => [];
}


class ConfirmationPaymentLoading extends ConfirmationPaymentState {
  @override
  List<Object> get props => [];
}

class ConfirmationPaymentLoaded extends ConfirmationPaymentState {
  @override
  List<Object> get props => [];
}

class ConfirmationPaymentLoadingFailed extends ConfirmationPaymentState {
  final String message;

  ConfirmationPaymentLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}