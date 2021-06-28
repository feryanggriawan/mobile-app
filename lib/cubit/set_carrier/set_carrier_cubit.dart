import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'set_carrier_state.dart';

class SetCarrierCubit extends Cubit<SetCarrierState> {
  SetCarrierCubit() : super(SetCarrierInitial());

  Future<void> setCarrier({String carrier, String order}) async {
    ApiReturnValue<bool> result =
    await OrderServices.setCarrier(carrier: carrier, order: order);

    if (result.value != null) {
      emit(SetCarrierLoaded());
    } else {
      emit(SetCarrierLoadingFailed(result.message));
    }
  }
}
