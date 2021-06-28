part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<Category> products;

  CategoryLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class CategoryLoadingFailed extends CategoryState {
  final int code;

  CategoryLoadingFailed(this.code);

  @override
  List<Object> get props => [code];
}
