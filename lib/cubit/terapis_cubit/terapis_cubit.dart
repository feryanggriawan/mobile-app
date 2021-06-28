import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'terapis_state.dart';

class TerapisCubit extends Cubit<TerapisState> {
  TerapisCubit() : super(TerapisInitial());

  Future<void> getTerapis({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<Terapis>> result =
    await TerapisServices.getTerapis(body);

    print(result);

    if (result.value != null) {
      emit(TerapisLoaded(result.value));
    } else {
      emit(TerapisLoadingFailed(result.message));
    }
  }

  Future<void> getSearchTerapis({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<Terapis>> result =
    await TerapisServices.getTerapisSearch(body);

    print(result);

    if (result.value != null) {
      emit(TerapisLoaded(result.value));
    } else {
      emit(TerapisLoadingFailed(result.message));
    }
  }
}
