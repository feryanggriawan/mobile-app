import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/models/order_history.dart';
import 'package:tsi_mobile/services/services.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  Future<void> getOrderHistory({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<OrderHistory>> result =
    await UserServices.getOrderHistory(body: body);

    print(result);

    if (result.value != null) {
      emit(OrderHistoryLoaded(result.value));
    } else {
      emit(OrderHistoryLoadingFailed(result.message));
    }
  }
}
