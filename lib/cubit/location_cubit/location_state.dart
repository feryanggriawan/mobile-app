part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationModel location;

  LocationLoaded(this.location);

  @override
  List<Object> get props => [location];
}

class LocationLoadingFailed extends LocationState {
  final String message;

  LocationLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
