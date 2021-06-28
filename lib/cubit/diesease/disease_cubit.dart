import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/disease.dart';
import 'package:tsi_mobile/services/disease_services.dart';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  DiseaseCubit() : super(DiseaseInitial());

  Future<void> getDisease() async {
    ApiReturnValue<List<Disease>> result =
    await DiseaseServices.getDiseases();

    print(result);

    if (result.value != null) {
      emit(DiseaseLoaded(result.value));
    } else {
      emit(DiseaseLoadingFailed(result.message));
    }
  }
}
