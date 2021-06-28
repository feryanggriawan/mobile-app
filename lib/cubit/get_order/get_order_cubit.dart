import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/detail_order.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'get_order_state.dart';

class GetOrderCubit extends Cubit<GetOrderState> {
  GetOrderCubit() : super(GetOrderInitial());

  Future<void> getOrder(String id, String order) async {
    await OrderServices.getUniqToken(order);
    ApiReturnValue<OrderDetail> result =
        await OrderServices.getCurrentOrder(id);

    if (result.value != null) {
      emit(GetOrderLoaded(result.value));
    } else {
      emit(GetOrderLoadingFailed(result.message));
    }
  }
}
