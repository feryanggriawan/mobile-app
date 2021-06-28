import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/services/services.dart';
import 'package:tsi_mobile/models/models.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getAllProducts() async {
    ApiReturnValue<List<ProductModel>> result =
        await ProductServices.getProducts("");

    print(result.value);

    if (result.value != null) {
      emit(ProductLoaded(result.value));
    } else {
      emit(ProductLoadingFailed(result.code));
    }
  }

  Future<void> getProductsCategory(String category) async {
    ApiReturnValue<List<ProductModel>> result =
    await ProductServices.getProductsCategory(category);

    print(result.value);

    if (result.value != null) {
      emit(ProductLoaded(result.value));
    } else {
      emit(ProductLoadingFailed(result.code));
    }
  }
}
