import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class BlogServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<List<Blog>>> getBlog(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "blog";

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

      List<Blog> values =
          (result['data'] as Iterable).map((e) => Blog.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<List<Blog>>> getSearchBlog(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "search/blog";

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

      List<Blog> values =
      (result['data'] as Iterable).map((e) => Blog.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
