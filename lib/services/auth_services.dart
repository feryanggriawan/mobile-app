import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class AuthServices {
  static Dio dio = Dio();

  // Login Service
  static Future<ApiReturnValue<UserModel>> login(
      {String account, String password}) async {
    try {
      String url = baseUrlApi + "login";

      FormData formData =
          FormData.fromMap({'account': account, 'password': password});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);
      var result = jsonDecode(response.data);

      print(result.runtimeType);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: UserModel.fromJson(result['data']));
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Register Service
  static Future<ApiReturnValue<UserModel>> register(
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
    try {
      String url = baseUrlApi + "register";

      FormData formData = FormData.fromMap({
        'name': name,
        'nik': nik,
        'id_certificate': idCertificate,
        'email': email,
        'phone': phone,
        'location': location,
        'address': address,
        'ktp': MultipartFile.fromFileSync(ktpUrl,
            filename: ktpUrl.split('/').last),
        'username': username,
        'password': password,
        'confirm_password': password,
      });

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);
      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      print(result['data']);

      return ApiReturnValue(value: UserModel.fromJson(result['data']));
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get Profile Service
  static Future<ApiReturnValue<UserModel>> getProfile(int userId) async {
    try {
      String url = baseUrlApi + "profile";

      FormData formData = FormData.fromMap({'user': "$userId"});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);
      var result = jsonDecode(response.data);

      print(result.runtimeType);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: UserModel.fromJson(result['data']));
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
