part of 'get_order_cubit.dart';

abstract class GetOrderState extends Equatable {
  const GetOrderState();
}

class GetOrderInitial extends GetOrderState {
  @override
  List<Object> get props => [];
}

class GetOrderLoaded extends GetOrderState {
  final OrderDetail order;

  GetOrderLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class GetOrderLoadingFailed extends GetOrderState {
  final String message;

  GetOrderLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
