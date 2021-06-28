import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/disease.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class DiseaseServices {
  static Dio dio = Dio();

  // Get stories
  static Future<ApiReturnValue<List<Disease>>> getDiseases() async {
    try {
      String url = baseUrlApi + "penyakit";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.get(
        url,
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<Disease> value =
          (result['data'] as Iterable).map((e) => Disease.fromJson(e)).toList();

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
