import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'district_state.dart';

class DistrictCubit extends Cubit<DistrictState> {
  DistrictCubit() : super(DistrictInitial());

  Future<void> getDistrict(int provinceId) async {
    ApiReturnValue<List<LocationModel>> result =
        await LocationServices.getLocations(
            provinceId: provinceId, target: "district");

    print(result.value);
    print(result.value[0].district);

    if (result.value != null) {
      emit(DistrictLoaded(result.value));
    } else {
      emit(DistrictLoadingFailed(result.message));
    }
  }
}
