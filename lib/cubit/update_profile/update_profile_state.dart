part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileLoaded extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileLoadingFailed extends UpdateProfileState {
  final String message;

  UpdateProfileLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
