part of 'disease_cubit.dart';

abstract class DiseaseState extends Equatable {
  const DiseaseState();
}

class DiseaseInitial extends DiseaseState {
  @override
  List<Object> get props => [];
}

class DiseaseLoaded extends DiseaseState {
  final List<Disease> diseases;

  DiseaseLoaded(this.diseases);

  @override
  List<Object> get props => [diseases];
}

class DiseaseLoadingFailed extends DiseaseState {
  final String message;

  DiseaseLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
