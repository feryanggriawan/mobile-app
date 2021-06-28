part of 'member_get_cubit.dart';

abstract class MemberGetState extends Equatable {
  const MemberGetState();
}

class MemberGetInitial extends MemberGetState {
  @override
  List<Object> get props => [];
}

class MemberGetLoaded extends MemberGetState {
  final List<Pasien> pasiens;

  MemberGetLoaded(this.pasiens);

  @override
  List<Object> get props => [pasiens];
}

class MemberGetLoadingFailed extends MemberGetState {
  final String message;

  MemberGetLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
