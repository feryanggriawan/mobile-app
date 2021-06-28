part of 'course_offline_cubit.dart';

abstract class CourseOfflineState extends Equatable {
  const CourseOfflineState();

  @override
  List<Object> get props => [];
}

class CourseOfflineInitial extends CourseOfflineState {}

class CourseOfflineLoaded extends CourseOfflineState {
  final List<CourseModel> coursesOffline;

  CourseOfflineLoaded(this.coursesOffline);

  @override
  List<Object> get props => [coursesOffline];
}

class CourseOfflineLoadingFailed extends CourseOfflineState {
  final int code;

  CourseOfflineLoadingFailed(this.code);

  @override
  List<Object> get props => [code];
}
