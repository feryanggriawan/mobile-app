import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class StoryServices {
  static Dio dio = Dio();

  // Get stories
  static Future<ApiReturnValue<List<StoryModel>>> getStories(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "story";

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

      List<StoryModel> values = (result['data'] as Iterable)
          .map((e) => StoryModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get stories
  static Future<ApiReturnValue<List<StoryModel>>> getStoriesSearch(
      Map<String, dynamic> body) async {
    try {
      String url = baseUrlApi + "search/story";

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

      List<StoryModel> values = (result['data'] as Iterable)
          .map((e) => StoryModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> updateStory(
      {@required FormData formData}) async {
    try {
      String url = baseUrlApi + "member/update_story";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      print(formData.fields.toList());

      var response = await dio.post(
        url,
        data: formData,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: e.message);
    }
  }

  static Future<ApiReturnValue<bool>> addStory(
      {@required FormData formData}) async {
    try {
      String url = baseUrlApi + "member/create_story";

      dio.options.headers["secret"] =
      "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      print(formData.fields.toList());

      var response = await dio.post(
        url,
        data: formData,
      );

      var result = jsonDecode(response.data);

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: e.message);
    }
  }
}
