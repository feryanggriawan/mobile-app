part of 'member_terapis_cubit.dart';

abstract class MemberTerapisState extends Equatable {
  const MemberTerapisState();
}

class MemberTerapisInitial extends MemberTerapisState {
  @override
  List<Object> get props => [];
}

class MemberTerapisLoaded extends MemberTerapisState {
  final Terapis terapis;

  MemberTerapisLoaded(this.terapis);

  @override
  List<Object> get props => [terapis];
}

class MemberTerapisLoadingFailed extends MemberTerapisState {
  final String message;

  MemberTerapisLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
