import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityInitial());

  Future<void> getCity(int provinceId) async {
    ApiReturnValue<List<LocationModel>> result =
        await LocationServices.getLocations(
            provinceId: provinceId, target: "city");

    print(result);

    if (result.value != null) {
      emit(CityLoaded(result.value));
    } else {
      emit(CityLoadingFailed(result.message));
    }
  }
}
