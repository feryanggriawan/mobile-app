import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tsi_mobile/models/carrier.dart';
import 'package:tsi_mobile/models/cart.dart';
import 'package:tsi_mobile/models/delivery_carrier.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/models/payment_method.dart';
import 'package:tsi_mobile/shared/shared.dart';

class OrderServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<Cart>> getCart(String id) async {
    try {
      String url = baseUrlApi + "order/cart";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"user": id},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      Cart value = Cart.fromJson(result);

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> addCourse({
    @required String id,
    @required String course,
    String discount = "0",
  }) async {
    try {
      String url = baseUrlApi + "order/add_course";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"user": id, "course": course, "discount": discount},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> addProduct({
    @required String id,
    @required String product,
    String variant = "",
    String qty = "1",
  }) async {
    try {
      String url = baseUrlApi + "order/add_product";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"user": id, "product": product, "variant": variant, "qty": qty},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> removeCart({
    @required String id,
    @required String cartId,
  }) async {
    try {
      String url = baseUrlApi + "order/remove_cart";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"user": id, "cart": cartId},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> changeQuantity({
    @required String cart,
    @required String qty,
  }) async {
    try {
      String url = baseUrlApi + "order/change_qty";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"cart": cart, "qty": qty},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get stories
  static Future<ApiReturnValue<OrderDetail>> getOrderDetail(
      String order) async {
    try {
      String url = baseUrlApi + "order/detail";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"order": order},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      OrderDetail value = OrderDetail.fromJson(result);

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get stories
  static Future<ApiReturnValue<List<DeliveryCarrier>>> getDeliveryCarrier(
      String order) async {
    try {
      String url = baseUrlApi + "order/carrier";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"order": order},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      List<DeliveryCarrier> values = (result['data'] as Iterable)
          .map((e) => DeliveryCarrier.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<List<Carrier>>> getCarrier() async {
    try {
      String url = baseUrlApi + "carrier?by=&service=";

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

      List<Carrier> values =
          (result['data'] as Iterable).map((e) => Carrier.fromJson(e)).toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> setCarrier(
      {String order, String carrier}) async {
    try {
      String url = baseUrlApi + "order/select_carrier";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(url, data: {
        "order": order,
        "carrier": carrier,
      });

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<List<PaymentMethod>>> getMethod() async {
    try {
      String url = baseUrlApi + "payment";

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

      List<PaymentMethod> values = (result['data'] as Iterable)
          .map((e) => PaymentMethod.fromJson(e))
          .toList();

      return ApiReturnValue(value: values);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> selectPaymentMethod(
      {String order, String payment}) async {
    try {
      String url = baseUrlApi + "order/select_payment";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(url, data: {
        "order": order,
        "payment": payment,
      });

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> getUniqToken(String order) async {
    try {
      String url = baseUrlApi + "order/uniq";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {"order": order},
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  // Get stories
  static Future<ApiReturnValue<bool>> checkoutCart(String user) async {
    try {
      String url = baseUrlApi + "order/checkout";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {
          "user": user,
        },
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<OrderDetail>> getCurrentOrder(
      String user) async {
    try {
      String url = baseUrlApi + "order";

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: {
          "user": user,
          "status": "0",
        },
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      OrderDetail value = OrderDetail.fromJson(result);

      return ApiReturnValue(value: value);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }

  static Future<ApiReturnValue<bool>> paymentConfirmation(
      {String date, String orderId, String file}) async {
    try {
      String url = baseUrlApi + "order/confirm_pay";

      FormData formData = FormData.fromMap({
        'order': orderId,
        'date': date,
        'receipt': MultipartFile.fromFileSync(file, filename: file.split('/').last),
      });

      dio.options.headers["secret"] =
          "w2Bd2NkVOamBtMyuM8Un3MWTeK6ZmXCBd3qsXsNY2bLDX7v1x6jw2Bd2N95j978Un3MWTeK6Z";

      var response = await dio.post(
        url,
        data: formData,
      );

      var result = jsonDecode(response.data);

      print(result.toString());

      if (result['code'] != 200) {
        return ApiReturnValue(message: result['msg']);
      }

      return ApiReturnValue(value: true);
    } on DioError catch (e) {
      print(e);
      return ApiReturnValue(message: "");
    }
  }
}
