import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/order_services.dart';
part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());

  Future<void> getOrderDetail(String id) async {
    ApiReturnValue<OrderDetail> result =
    await OrderServices.getOrderDetail(id);

    print(result);

    if (result.value != null) {
      emit(OrderDetailLoaded(result.value));
    } else {
      emit(OrderDetailLoadingFailed(result.message));
    }
  }
}
