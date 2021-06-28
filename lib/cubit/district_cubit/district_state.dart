part of 'district_cubit.dart';

abstract class DistrictState extends Equatable {
  const DistrictState();

  @override
  List<Object> get props => [];
}

class DistrictInitial extends DistrictState {}

class DistrictLoaded extends DistrictState {
  final List<LocationModel> districts;

  DistrictLoaded(this.districts);

  @override
  List<Object> get props => [districts];
}

class DistrictLoadingFailed extends DistrictState {
  final String message;

  DistrictLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
