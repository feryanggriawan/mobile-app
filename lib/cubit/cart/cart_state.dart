part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final Cart order;

  CartLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class CartLoadingFailed extends CartState {
  final String message;

  CartLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

