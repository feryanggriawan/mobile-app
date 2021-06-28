part of 'terapis_cubit.dart';

abstract class TerapisState extends Equatable {
  const TerapisState();
}

class TerapisInitial extends TerapisState {
  @override
  List<Object> get props => [];
}


class TerapisLoaded extends TerapisState {
  final List<Terapis> terapies;

  TerapisLoaded(this.terapies);

  @override
  List<Object> get props => [terapies];
}

class TerapisLoadingFailed extends TerapisState {
  final String message;

  TerapisLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
