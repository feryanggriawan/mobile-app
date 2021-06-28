part of 'order_history_cubit.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();
}

class OrderHistoryInitial extends OrderHistoryState {
  @override
  List<Object> get props => [];
}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<OrderHistory> terapies;

  OrderHistoryLoaded(this.terapies);

  @override
  List<Object> get props => [terapies];
}

class OrderHistoryLoadingFailed extends OrderHistoryState {
  final String message;

  OrderHistoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
