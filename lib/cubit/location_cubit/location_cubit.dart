import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> getLocation(int provinceId) async {
    ApiReturnValue<LocationModel> result = await LocationServices.getLocation(
        provinceId: provinceId, target: "address");

    print(result);

    if (result.value != null) {
      emit(LocationLoaded(result.value));
    } else {
      emit(LocationLoadingFailed(result.message));
    }
  }
}
