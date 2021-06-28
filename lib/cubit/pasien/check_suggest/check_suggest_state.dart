part of 'check_suggest_cubit.dart';

abstract class CheckSuggestState extends Equatable {
  const CheckSuggestState();
}

class CheckSuggestInitial extends CheckSuggestState {
  @override
  List<Object> get props => [];
}

class CheckSuggestLoaded extends CheckSuggestState {
  final Suggest suggest;

  CheckSuggestLoaded(this.suggest);

  @override
  List<Object> get props => [suggest];
}

class CheckSuggestLoadingFailed extends CheckSuggestState {
  final String message;

  CheckSuggestLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

