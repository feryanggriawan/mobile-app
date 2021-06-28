part of 'story_cubit.dart';

abstract class StoryState extends Equatable {
  const StoryState();
}

class StoryInitial extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryLoaded extends StoryState {
  final List<StoryModel> stories;

  StoryLoaded(this.stories);

  @override
  List<Object> get props => [stories];
}

class StoryLoadingFailed extends StoryState {
  final String message;

  StoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
