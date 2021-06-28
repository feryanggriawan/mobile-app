import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'course_online_state.dart';

class CourseOnlineCubit extends Cubit<CourseOnlineState> {
  CourseOnlineCubit() : super(CourseOnlineInitial());

  Future<void> getCoursesOnline() async {
    ApiReturnValue<List<CourseModel>> result =
        await CourseServices.getCoursesType("online");

    print(result.value);

    if (result.value != null) {
      emit(CourseOnlineLoaded(result.value));
    } else {
      emit(CourseOnlineLoadingFailed(result.code));
    }
    // } else {
    //   emit(CourseOnlineLoadingFailed(message: result.message));
    // }
  }
}
