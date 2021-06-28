part of 'course_online_cubit.dart';

abstract class CourseOnlineState extends Equatable {
  const CourseOnlineState();

  @override
  List<Object> get props => [];
}

class CourseOnlineInitial extends CourseOnlineState {}

class CourseOnlineLoaded extends CourseOnlineState {
  final List<CourseModel> coursesOnline;

  CourseOnlineLoaded(this.coursesOnline);

  @override
  List<Object> get props => [coursesOnline];
}

class CourseOnlineLoadingFailed extends CourseOnlineState {
  final int code;

  CourseOnlineLoadingFailed(this.code);

  @override
  List<Object> get props => [code];
}
