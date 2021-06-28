import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class CourseServices {
  static Dio dio = Dio();

  // Get Crouses by Type (offline/online)
  static Future<ApiReturnValue<List<CourseModel>>> getCoursesType(
      String type) async {
    try {
      String url = baseUrlApi + "course";

      FormData formData = FormData.fromMap({'type': type});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);

      var result = jsonDecode(response.data);

      print(result);

      if (result['code'] != 200) {
        return ApiReturnValue(code: result['code']);
      }

      List<CourseModel> values = (result['data'] as Iterable)
          .map((e) => CourseModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(code: e.response.statusCode);
    }
  }
}
