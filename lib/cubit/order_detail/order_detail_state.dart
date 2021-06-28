part of 'order_detail_cubit.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();
}

class OrderDetailInitial extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoaded extends OrderDetailState {
  final OrderDetail order;

  OrderDetailLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class OrderDetailLoadingFailed extends OrderDetailState {
  final String message;

  OrderDetailLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
