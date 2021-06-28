import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/delivery_address.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/models/order_history.dart';
import 'package:tsi_mobile/shared/shared.dart';

class UserServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<bool>> updateProfile(
      {@required FormData formData}) async {
    try {
      String url = baseUrlApi + "member/update_profile";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      print(formData.fields.toList());

      var response = await dio.post(
        url,
        data: formData,
      );

      print(response.statusCode);

      var result = jsonDecode(response.data);

      if (response.statusCode != 200 || result['code'] != 200) {
        throw {
          "message": result["msg"],
        };
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: e.message);
    } catch (e) {
      return ApiReturnValue(message: e.message);
    }
  }

  static Future<ApiReturnValue<bool>> updateAccount(
      {@required FormData formData}) async {
    try {
      String url = baseUrlApi + "member/update_account";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      print(formData.fields.toList());

      var response = await dio.post(
        url,
        data: formData,
      );

      print(response.statusCode);

      var result = jsonDecode(response.data);

      print(result);

      if (result['code'] != 200) {
        throw result["msg"];
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: e.message);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<List<OrderHistory>>> getOrderHistory(
      {@required Map<String,dynamic> body}) async {
    try {
      String url = baseUrlApi + "order_history";

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

      List<OrderHistory> values =
      (result['data'] as Iterable).map((e) => OrderHistory.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<DeliveryAddress>> updateAddress(
      {@required Map<String,dynamic> body}) async {
    try {
      String url = baseUrlApi + "order/update_address";

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
      
      DeliveryAddress deliveryAddress = DeliveryAddress.fromJson(result);

      return ApiReturnValue(value: deliveryAddress);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
