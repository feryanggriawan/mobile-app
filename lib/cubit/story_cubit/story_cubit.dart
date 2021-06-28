import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  Future<void> getStories({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<StoryModel>> result =
        await StoryServices.getStories(body);

    print(result);

    if (result.value != null) {
      emit(StoryLoaded(result.value));
    } else {
      emit(StoryLoadingFailed(result.message));
    }
  }

  Future<void> getSearchStories({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<StoryModel>> result =
        await StoryServices.getStoriesSearch(body);

    print(result);

    if (result.value != null) {
      emit(StoryLoaded(result.value));
    } else {
      emit(StoryLoadingFailed(result.message));
    }
  }
}
