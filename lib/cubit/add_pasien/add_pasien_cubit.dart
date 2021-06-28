import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/api_return_value.dart';
import 'package:tsi_mobile/models/pasien/add.dart';
import 'package:tsi_mobile/services/pasien_services.dart';
import 'package:tsi_mobile/services/services.dart';

part 'add_pasien_state.dart';

class AddPasienCubit extends Cubit<AddPasienState> {
  AddPasienCubit() : super(AddPasienInitial());

  Future<void> addPasien({@required FormData story, @required FormData pasien}) async {
    try{
      pasien.fields.map((e) => print(e.key)).toList();

      ApiReturnValue<AddPasien> _pasien =
      await PasienServices.addPasien(pasien);

      print(_pasien.message);

      story.fields.add(
        MapEntry("pasien", _pasien.value.pasienId.toString())
      );

      await StoryServices.addStory(formData: story);

      print(_pasien);

      if (_pasien.value != null) {
        emit(AddPasienLoaded());
      } else {
        emit(AddPasienLoadingFailed(_pasien.message));
      }
    }catch(e){
      emit(AddPasienLoadingFailed(e.toString()));
    }
  }
}
