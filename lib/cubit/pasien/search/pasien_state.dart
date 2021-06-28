part of 'pasien_cubit.dart';

abstract class PasienState extends Equatable {
  const PasienState();
}

class PasienInitial extends PasienState {
  @override
  List<Object> get props => [];
}

class PasienLoaded extends PasienState {
  final List<Pasien> pasiens;

  PasienLoaded(this.pasiens);

  @override
  List<Object> get props => [pasiens];
}

class PasienLoadingFailed extends PasienState {
  final String message;

  PasienLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
