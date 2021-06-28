import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/category.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> getAllCategory(String category) async {
    ApiReturnValue<List<Category>> result =
    await ProductServices.category(category);

    print(result.value);

    if (result.value != null) {
      emit(CategoryLoaded(result.value));
    } else {
      emit(CategoryLoadingFailed(result.code));
    }
  }
}
