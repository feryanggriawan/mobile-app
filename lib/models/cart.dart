import 'package:tsi_mobile/models/models.dart';

class Cart {
  int code;
  bool success;
  String msg;
  int countCart;
  int orderId;
  String invoice;
  String subtotal;
  String discount;
  String detailDiscount;
  String shipping;
  String shippingHistory;
  String total;
  String payment;
  String address;
  String carrier;
  String status;
  String statusHistory;
  dynamic uniq;
  dynamic receipt;
  dynamic expired;
  String created;
  OrderData data;

  Cart(
      {this.code,
      this.success,
      this.msg,
      this.countCart,
      this.orderId,
      this.invoice,
      this.subtotal,
      this.discount,
      this.detailDiscount,
      this.shipping,
      this.shippingHistory,
      this.total,
      this.payment,
      this.address,
      this.carrier,
      this.status,
      this.statusHistory,
      this.uniq,
      this.receipt,
      this.expired,
      this.created,
      this.data});

  Cart.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msg = json['msg'];
    countCart = json['count_cart'];
    orderId = json['order_id'];
    invoice = json['invoice'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    detailDiscount = json['detail_discount'];
    shipping = json['shipping'];
    shippingHistory = json['shipping_history'];
    total = json['total'];
    payment = json['payment'];
    address = json['address'];
    carrier = json['carrier'];
    status = json['status'];
    statusHistory = json['status_history'];
    uniq = json['uniq'];
    receipt = json['receipt'];
    expired = json['expired'];
    created = json['created'];
    data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg'] = this.msg;
    data['count_cart'] = this.countCart;
    data['order_id'] = this.orderId;
    data['invoice'] = this.invoice;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['detail_discount'] = this.detailDiscount;
    data['shipping'] = this.shipping;
    data['shipping_history'] = this.shippingHistory;
    data['total'] = this.total;
    data['payment'] = this.payment;
    data['address'] = this.address;
    data['carrier'] = this.carrier;
    data['status'] = this.status;
    data['status_history'] = this.statusHistory;
    data['uniq'] = this.uniq;
    data['receipt'] = this.receipt;
    data['expired'] = this.expired;
    data['created'] = this.created;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OrderData {
  int cartCourse;
  List<CourseDetail> course;
  int cartProduct;
  List<Product> product;

  OrderData({this.cartCourse, this.course, this.cartProduct, this.product});

  OrderData.fromJson(Map<String, dynamic> json) {
    cartCourse = json['cart_course'];
    if (json['course'] != null) {
      course = new List<CourseDetail>();
      json['course'].forEach((v) {
        course.add(new CourseDetail.fromJson(v));
      });
    }
    cartProduct = json['cart_product'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_course'] = this.cartCourse;
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
    data['cart_product'] = this.cartProduct;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
