import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  Future<void> getBanners() async {
    ApiReturnValue<List<BannerModel>> result =
        await BannerServices.getBanners();

    print(result.value);

    if (result.value != null) {
      emit(BannerLoaded(result.value));
    } else if (int.parse(result.message) >= 500) {
      emit(BannerLoadingFailed(result.message));
    } else {
      emit(BannerLoaded(result.value));
    }
  }
}
