import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'subdistrict_state.dart';

class SubdistrictCubit extends Cubit<SubdistrictState> {
  SubdistrictCubit() : super(SubdistrictInitial());

  Future<void> getSubdistrict(int provinceId) async {
    ApiReturnValue<List<LocationModel>> result =
        await LocationServices.getLocations(
            provinceId: provinceId, target: "subdistrict");

    print(result);

    if (result.value != null) {
      emit(SubdistrictLoaded(result.value));
    } else {
      emit(SubdistrictLoadingFailed(result.message));
    }
  }
}
