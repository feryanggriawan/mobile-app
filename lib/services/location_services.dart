import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class LocationServices {
  static Dio dio = Dio();

  // Get Province
  static Future<ApiReturnValue<List<ProvinceModel>>> getProvince() async {
    try {
      String url = baseUrlApi + "province";

      var response = await dio.get(
        url,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<ProvinceModel> values = (result['data'] as Iterable)
          .map((e) => ProvinceModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get Locations
  static Future<ApiReturnValue<List<LocationModel>>> getLocations(
      {int provinceId, String target}) async {
    try {
      String url = baseUrlApi + "location";

      FormData formData =
          FormData.fromMap({'from_id': provinceId, 'target': target});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<LocationModel> values = (result['data'] as Iterable)
          .map((e) => LocationModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get Location
  static Future<ApiReturnValue<LocationModel>> getLocation(
      {int provinceId, String target}) async {
    try {
      String url = baseUrlApi + "location";

      FormData formData =
          FormData.fromMap({'from_id': provinceId, 'target': target});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: LocationModel.fromJson(result['data']));
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
