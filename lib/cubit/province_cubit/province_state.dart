part of 'province_cubit.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final List<ProvinceModel> provinces;

  ProvinceLoaded(this.provinces);

  @override
  List<Object> get props => [provinces];
}

class ProvinceLoadingFailed extends ProvinceState {
  final String message;

  ProvinceLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
