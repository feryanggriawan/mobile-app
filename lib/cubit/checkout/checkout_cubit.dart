import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/services/services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> checkout(String id, ) async {
    ApiReturnValue<bool> result =
    await OrderServices.checkoutCart(id);

    if (result.value != null) {
      emit(CheckoutLoaded());
    } else {
      emit(CheckoutLoadingFailed(result.message));
    }
  }
}
