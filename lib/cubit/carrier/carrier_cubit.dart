import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/carrier.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'carrier_state.dart';

class CarrierCubit extends Cubit<CarrierState> {
  CarrierCubit() : super(CarrierInitial());

  Future<void> getCarrier() async {
    ApiReturnValue<List<Carrier>> result =
    await OrderServices.getCarrier();

    print(result);

    if (result.value != null) {
      emit(CarriersLoaded(result.value));
    } else {
      emit(CarriersLoadingFailed(result.message));
    }
  }
}
