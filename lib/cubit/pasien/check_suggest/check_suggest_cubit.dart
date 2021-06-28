import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/pasien_services.dart';

part 'check_suggest_state.dart';

class CheckSuggestCubit extends Cubit<CheckSuggestState> {
  CheckSuggestCubit() : super(CheckSuggestInitial());

  Future<void> checkSuggest({@required Map<String, dynamic> body}) async {
    ApiReturnValue<Suggest> result =
    await PasienServices.checkSuggest(body);

    if (result.value != null) {
      emit(CheckSuggestLoaded(result.value));
    } else {
      print(result.message);
      emit(CheckSuggestLoadingFailed(result.message));
    }
  }
}
