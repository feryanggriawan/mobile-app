import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> login(String account, String password) async {
    ApiReturnValue<UserModel> result =
        await AuthServices.login(account: account, password: password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> register(
      {String name,
      String nik,
      String idCertificate,
      String email,
      String phone,
      String location,
      String address,
      String ktpUrl,
      String username,
      String password}) async {
    ApiReturnValue<UserModel> result = await AuthServices.register(
        name: name,
        nik: nik,
        idCertificate: idCertificate,
        email: email,
        phone: phone,
        location: location,
        address: address,
        ktpUrl: ktpUrl,
        username: username,
        password: password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> getProfile(int userId) async {
    ApiReturnValue<UserModel> result = await AuthServices.getProfile(userId);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }
}
