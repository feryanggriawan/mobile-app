import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'set_payment_method_state.dart';

class SetPaymentMethodCubit extends Cubit<SetPaymentMethodState> {
  SetPaymentMethodCubit() : super(SetPaymentMethodInitial());

  Future<void> setPaymentMethod({String payment, String order}) async {
    ApiReturnValue<bool> result =
        await OrderServices.selectPaymentMethod(order: order, payment: payment);

    print(result.value);

    if (result.value != null) {
      print("go");
      emit(SetPaymentMethodLoaded());
      print("go");
    } else {
      print("no");
      emit(SetPaymentMethodLoadingFailed(result.message));
    }
  }
}
