import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class TerapisServices {
  static Dio dio = Dio();

  // Get stories
  static Future<ApiReturnValue<List<Terapis>>> getTerapis(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "terapis";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: body,
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<Terapis> values =
          (result['data'] as Iterable).map((e) => Terapis.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

// Get stories
  static Future<ApiReturnValue<List<Terapis>>> getTerapisSearch(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "search/terapis";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: body,
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<Terapis> values =
          (result['data'] as Iterable).map((e) => Terapis.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<Terapis>> getMemberTerapis(String id) async {
    try {
      String url = baseUrlApi + "member/terapis";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {
          "user": id,
        },
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      Terapis value = Terapis.fromJson(
        result["data"],
      );

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
