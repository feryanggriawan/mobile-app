import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/delivery_address.dart';
import 'package:tsi_mobile/services/services.dart';

part 'set_delivery_address_state.dart';

class SetDeliveryAddressCubit extends Cubit<SetDeliveryAddressState> {
  SetDeliveryAddressCubit() : super(SetDeliveryAddressInitial());

  Future<void> deliveryAddress({@required Map<String, dynamic> body}) async {
    ApiReturnValue<DeliveryAddress> result =
        await UserServices.updateAddress(body: body);

    print(result);

    if (result.value != null) {
      emit(SetDeliveryAddressLoaded(result.value));
    } else {
      emit(SetDeliveryAddressLoadingFailed(result.message));
    }
  }
}
