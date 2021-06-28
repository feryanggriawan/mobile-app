import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/delivery_carrier.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'get_delivery_carrier_state.dart';

class GetDeliveryCarrierCubit extends Cubit<GetDeliveryCarrierState> {
  GetDeliveryCarrierCubit() : super(GetDeliveryCarrierInitial());

  Future<void> getDeliveryCarrier({@required String order}) async {
    ApiReturnValue<List<DeliveryCarrier>> result =
        await OrderServices.getDeliveryCarrier(order);

    print(result);

    if (result.value != null) {
      emit(GetDeliveryCarrierLoaded(result.value));
    } else {
      emit(GetDeliveryCarrierLoadingFailed(result.message));
    }
  }
}
