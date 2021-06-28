part of 'city_cubit.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoaded extends CityState {
  final List<LocationModel> citys;

  CityLoaded(this.citys);

  @override
  List<Object> get props => [citys];
}

class CityLoadingFailed extends CityState {
  final String message;

  CityLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
