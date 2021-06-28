import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/pasien_services.dart';

part 'pasien_state.dart';

class PasienCubit extends Cubit<PasienState> {
  PasienCubit() : super(PasienInitial());

  Future<void> getSearchPasien({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<Pasien>> result =
    await PasienServices.getPasienSearch(body);

    if (result.value != null) {
      emit(PasienLoaded(result.value));
    } else {
      emit(PasienLoadingFailed(result.message));
    }
  }
}
