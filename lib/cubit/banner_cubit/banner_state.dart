part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoaded extends BannerState {
  final List<BannerModel> banners;

  BannerLoaded(this.banners);

  @override
  List<Object> get props => [banners];
}

class BannerLoadingFailed extends BannerState {
  final String message;

  BannerLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
