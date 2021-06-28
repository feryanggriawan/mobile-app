import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/models/pasien/main.dart';
import 'package:tsi_mobile/services/pasien_services.dart';

part 'member_get_state.dart';

class MemberGetCubit extends Cubit<MemberGetState> {
  MemberGetCubit() : super(MemberGetInitial());

  Future<void> getMemberPasien({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<Pasien>> result =
    await PasienServices.getPasienMember(body);

    if (result.value != null) {
      emit(MemberGetLoaded(result.value));
    } else {
      emit(MemberGetLoadingFailed(result.message));
    }
  }
}
