import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class BannerServices {
  static Dio dio = Dio();

  // Get Crouses by Type (offline/online)
  static Future<ApiReturnValue<List<BannerModel>>> getBanners() async {
    try {
      String url = baseUrlApi + "banner";

      var response = await dio.get(url);

      var result = jsonDecode(response.data);

      print(result);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['code'].toString());
      }

      List<BannerModel> values = (result['data'] as Iterable)
          .map((e) => BannerModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
