part of 'update_story_cubit.dart';

abstract class UpdateStoryState extends Equatable {
  const UpdateStoryState();
}

class UpdateStoryInitial extends UpdateStoryState {
  @override
  List<Object> get props => [];
}

class UpdateStoryLoaded extends UpdateStoryState {
  @override
  List<Object> get props => [];
}

class UpdateStoryLoadingFailed extends UpdateStoryState {
  final String message;

  UpdateStoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

