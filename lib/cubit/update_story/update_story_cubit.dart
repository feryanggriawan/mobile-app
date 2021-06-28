import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'update_story_state.dart';

class UpdateStoryCubit extends Cubit<UpdateStoryState> {
  UpdateStoryCubit() : super(UpdateStoryInitial());

  Future<void> updateStory({@required FormData body}) async {
    ApiReturnValue<bool> result =
    await StoryServices.updateStory(formData: body);

    print(result);

    if (result.value != null) {
      emit(UpdateStoryLoaded());
    } else {
      emit(UpdateStoryLoadingFailed(result.message));
    }
  }

  Future<void> addStory({@required FormData body}) async {
    ApiReturnValue<bool> result =
    await StoryServices.addStory(formData: body);

    print(result);

    if (result.value != null) {
      emit(UpdateStoryLoaded());
    } else {
      emit(UpdateStoryLoadingFailed(result.message));
    }
  }
}
