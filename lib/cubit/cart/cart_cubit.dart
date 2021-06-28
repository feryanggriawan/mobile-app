import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/cart.dart';
import 'package:tsi_mobile/services/order_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart(String id) async {
    ApiReturnValue<Cart> result = await OrderServices.getCart(id);

    print(result);

    if (result.value != null) {
      emit(CartLoaded(result.value));
    } else {
      emit(CartLoadingFailed(result.message));
    }
  }

  Future<void> deleteCart(String userId, String cartId) async {
    ApiReturnValue<bool> result =
        await OrderServices.removeCart(id: userId, cartId: cartId);

    if (result.value != null) {
      getCart(userId);
    } else {
      emit(CartLoadingFailed(result.message));
    }
  }

  Future<void> changeCartQuantity(
      {String cart, String qty, String userId}) async {
    ApiReturnValue<bool> result =
        await OrderServices.changeQuantity(cart: cart, qty: qty);

    if (result.value != null) {
      getCart(userId);
    } else {
      emit(CartLoadingFailed(result.message));
    }
  }

  Future<void> addCourse(
      {String courseId, String discount, String userId}) async {
    ApiReturnValue<bool> result = await OrderServices.addCourse(
        id: userId, course: courseId, discount: discount);

    if (result.value != null) {
      getCart(userId);
    } else {
      emit(CartLoadingFailed(result.message));
    }
  }

  Future<void> addProduct(
      {String productId, String variant, String userId, String qty = "1"}) async {
    ApiReturnValue<bool> result = await OrderServices.addProduct(
        id: userId, product: productId, variant: variant, qty: qty);

    if (result.value != null) {
      getCart(userId);
    } else {
      emit(CartLoadingFailed(result.message));
    }
  }
}
