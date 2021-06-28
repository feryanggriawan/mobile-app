import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'course_offline_state.dart';

class CourseOfflineCubit extends Cubit<CourseOfflineState> {
  CourseOfflineCubit() : super(CourseOfflineInitial());

  Future<void> getCoursesOffline() async {
    ApiReturnValue<List<CourseModel>> result =
        await CourseServices.getCoursesType("offline");

    print(result.value);

    if (result.value != null) {
      emit(CourseOfflineLoaded(result.value));
    } else {
      emit(CourseOfflineLoadingFailed(result.code));
    }
    // } else {
    //   emit(CourseOfflineLoadingFailed(message: result.message));
    // }
  }
}
