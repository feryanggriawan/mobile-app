part of 'add_pasien_cubit.dart';

abstract class AddPasienState extends Equatable {
  const AddPasienState();
}

class AddPasienInitial extends AddPasienState {
  @override
  List<Object> get props => [];
}

class AddPasienLoaded extends AddPasienState {
  @override
  List<Object> get props => [];
}

class AddPasienLoadingFailed extends AddPasienState {
  final String message;

  AddPasienLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}