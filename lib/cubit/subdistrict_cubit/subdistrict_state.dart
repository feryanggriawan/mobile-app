part of 'subdistrict_cubit.dart';

abstract class SubdistrictState extends Equatable {
  const SubdistrictState();

  @override
  List<Object> get props => [];
}

class SubdistrictInitial extends SubdistrictState {}

class SubdistrictLoaded extends SubdistrictState {
  final List<LocationModel> subdistricts;

  SubdistrictLoaded(this.subdistricts);

  @override
  List<Object> get props => [subdistricts];
}

class SubdistrictLoadingFailed extends SubdistrictState {
  final String message;

  SubdistrictLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
