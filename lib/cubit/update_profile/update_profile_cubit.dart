import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  Future<void> updateProfile({@required FormData body}) async {
    ApiReturnValue<bool> result =
    await UserServices.updateProfile(formData: body);

    if (result.value != null) {
      emit(UpdateProfileLoaded());
    } else {
      emit(UpdateProfileLoadingFailed(result.message));
    }
  }

  Future<void> updateAccount({@required FormData body}) async {
    ApiReturnValue<bool> result =
    await UserServices.updateAccount(formData: body);

    if (result.value != null) {
      emit(UpdateProfileLoaded());
    } else {
      emit(UpdateProfileLoadingFailed(result.message));
    }
  }
}
