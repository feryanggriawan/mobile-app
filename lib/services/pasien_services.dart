import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/models/pasien/add.dart';
import 'package:tsi_mobile/shared/shared.dart';

class PasienServices {
  static Dio dio = Dio();

  // Get pasien
  static Future<ApiReturnValue<List<Pasien>>> getPasienMember(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "member/pasien";

      dio.options.headers["secret"] = secret;

      var response = await dio.post(
        url,
        data: body,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<Pasien> values =
          (result['data'] as Iterable).map((e) => Pasien.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

// Get pasien
  static Future<ApiReturnValue<List<Pasien>>> getPasienSearch(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "search/pasien";

      dio.options.headers["secret"] = secret;

      var response = await dio.post(
        url,
        data: body,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<Pasien> values =
          (result['data'] as Iterable).map((e) => Pasien.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<Suggest>> checkSuggest(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "member/cek_suggest";

      dio.options.headers["secret"] = secret;

      var response = await dio.post(
        url,
        data: body,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      Suggest value = Suggest.fromJson(result);

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<AddPasien>> addPasien(
      FormData body) async {
    try {
      String url = baseUrlApi + "member/add_pasien";

      dio.options.headers["secret"] = secret;

      var response = await dio.post(
        url,
        data: body,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      AddPasien value = AddPasien.fromJson(result);

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
