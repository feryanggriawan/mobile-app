import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  ProvinceCubit() : super(ProvinceInitial());

  Future<void> getProvinces() async {
    ApiReturnValue<List<ProvinceModel>> result =
        await LocationServices.getProvince();

    print(result.value);

    if (result.value != null) {
      emit(ProvinceLoaded(result.value));
    } else {
      emit(ProvinceLoadingFailed(result.message));
    }
  }
}
