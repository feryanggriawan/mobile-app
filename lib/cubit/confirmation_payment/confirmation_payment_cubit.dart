import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'confirmation_payment_state.dart';

class ConfirmationPaymentCubit extends Cubit<ConfirmationPaymentState> {
  ConfirmationPaymentCubit() : super(ConfirmationPaymentInitial());

  Future<void> confirmation({
    String orderId,
    String date,
    String file,
  }) async {
    emit(ConfirmationPaymentLoading());

    ApiReturnValue<bool> result = await OrderServices.paymentConfirmation(
      file: file,
      date: date,
      orderId: orderId,
    );

    if (result.value != null) {
      emit(ConfirmationPaymentLoaded());
    } else {
      emit(ConfirmationPaymentLoadingFailed(result.message));
    }
  }
}
