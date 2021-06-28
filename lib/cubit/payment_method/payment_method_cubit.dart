import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/payment_method.dart';
import 'package:tsi_mobile/services/services.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  Future<void> getPaymentMethod() async {
    ApiReturnValue<List<PaymentMethod>> result =
        await OrderServices.getMethod();

    print(result);

    if (result.value != null) {
      emit(PaymentMethodLoaded(result.value));
    } else {
      emit(PaymentMethodLoadingFailed(result.message));
    }
  }
}
