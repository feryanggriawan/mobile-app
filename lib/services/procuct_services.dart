import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tsi_mobile/models/category.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';

class ProductServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<List<Category>>> category(
      String category) async {
    try {
      String url = baseUrlApi + "category";

      FormData formData = FormData.fromMap({'category': category});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);

      var result = jsonDecode(response.data);

      print(result);

      if (result['code'] != 200) {
        return ApiReturnValue(code: result['code']);
      }

      List<Category> values = (result['data'] as Iterable)
          .map((e) => Category.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(code: e.response.statusCode);
    }
  }


  // Get Products Category by id and all
  static Future<ApiReturnValue<List<ProductModel>>> getProductsCategory(
      String category) async {
    try {
      String url = baseUrlApi + "product_category";

      FormData formData = FormData.fromMap({'category': category});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);

      var result = jsonDecode(response.data);

      print(result);

      if (result['code'] != 200) {
        return ApiReturnValue(code: result['code']);
      }

      List<ProductModel> values = (result['data'] as Iterable)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(code: e.response.statusCode);
    }
  }

  static Future<ApiReturnValue<List<ProductModel>>> getProducts(
      String product) async {
    try {
      String url = baseUrlApi + "product";

      FormData formData = FormData.fromMap({'product': product});

      dio.options.headers["secret"] = secret;

      var response = await dio.post(url, data: formData);

      var result = jsonDecode(response.data);

      print(result);

      if (result['code'] != 200) {
        return ApiReturnValue(code: result['code']);
      }

      List<ProductModel> values = (result['data'] as Iterable)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(code: e.response.statusCode);
    }
  }
}
