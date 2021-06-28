import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'member_terapis_state.dart';

class MemberTerapisCubit extends Cubit<MemberTerapisState> {
  MemberTerapisCubit() : super(MemberTerapisInitial());

  Future<void> getTerapis({@required String id}) async {
    ApiReturnValue<Terapis> result =
    await TerapisServices.getMemberTerapis(id);

    print(result);

    if (result.value != null) {
      emit(MemberTerapisLoaded(result.value));
    } else {
      emit(MemberTerapisLoadingFailed(result.message));
    }
  }
}
