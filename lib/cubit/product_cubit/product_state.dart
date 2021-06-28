part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductLoadingFailed extends ProductState {
  final int code;

  ProductLoadingFailed(this.code);

  @override
  List<Object> get props => [code];
}
