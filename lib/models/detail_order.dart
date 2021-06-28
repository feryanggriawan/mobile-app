class OrderDetail {
  int code;
  bool success;
  String msg;
  int orderId;
  String invoice;
  String subtotal;
  dynamic discount;
  dynamic detailDiscount;
  dynamic shipping;
  String shippingHistory;
  String total;
  String payment;
  String address;
  dynamic carrier;
  String status;
  String statusHistory;
  String uniq;
  dynamic receipt;
  String expired;
  String created;
  OrderDetailData data;

  OrderDetail(
      {this.code,
      this.success,
      this.msg,
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

  OrderDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msg = json['msg'];
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
    data = json['data'] != null
        ? new OrderDetailData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg'] = this.msg;
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

class OrderDetailData {
  OrderUser user;
  int cartCourse;
  List<CourseDetail> course;
  int cartProduct;
  List<Product> product;

  OrderDetailData(
      {this.user,
      this.cartCourse,
      this.course,
      this.cartProduct,
      this.product});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new OrderUser.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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

class OrderUser {
  int id;
  String name;
  String phone;

  OrderUser({this.id, this.name, this.phone});

  OrderUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class CourseDetail {
  int cartId;
  String courseId;
  String name;
  String subtotal;
  String discount;
  String detailDiscount;
  String qty;
  String total;
  dynamic note;
  int countOrderImage;
  List<OrderImage> image;

  CourseDetail(
      {this.cartId,
      this.courseId,
      this.name,
      this.subtotal,
      this.discount,
      this.detailDiscount,
      this.qty,
      this.total,
      this.note,
      this.countOrderImage,
      this.image});

  CourseDetail.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    courseId = json['course_id'];
    name = json['name'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    detailDiscount = json['detail_discount'];
    qty = json['qty'];
    total = json['total'];
    note = json['note'];
    countOrderImage = json['count_image'];
    if (json['image'] != null) {
      image = new List<OrderImage>();
      json['image'].forEach((v) {
        image.add(new OrderImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['detail_discount'] = this.detailDiscount;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['note'] = this.note;
    data['count_image'] = this.countOrderImage;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int cartId;
  String productId;
  String name;
  String subtotal;
  String discount;
  String variant;
  String detailVariant;
  String qty;
  String total;
  dynamic note;
  int countOrderImage;
  List<OrderImage> image;

  Product(
      {this.cartId,
      this.productId,
      this.name,
      this.subtotal,
      this.discount,
      this.variant,
      this.detailVariant,
      this.qty,
      this.total,
      this.note,
      this.countOrderImage,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    name = json['name'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    variant = json['variant'];
    detailVariant = json['detail_variant'];
    qty = json['qty'];
    total = json['total'];
    note = json['note'];
    countOrderImage = json['count_image'];
    if (json['image'] != null) {
      image = new List<OrderImage>();
      json['image'].forEach((v) {
        image.add(new OrderImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['variant'] = this.variant;
    data['detail_variant'] = this.detailVariant;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['note'] = this.note;
    data['count_image'] = this.countOrderImage;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderImage {
  int id;
  dynamic url;
  String file;

  OrderImage({this.id, this.url, this.file});

  OrderImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['file'] = this.file;
    return data;
  }
}
