class OrderHistory {
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
  int countItem;
  int countCourse;
  int countProduct;
  String expired;
  String created;

  OrderHistory(
      {this.orderId,
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
      this.countItem,
      this.countCourse,
      this.countProduct,
      this.expired,
      this.created});

  OrderHistory.fromJson(Map<String, dynamic> json) {
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
    countItem = json['count_item'];
    countCourse = json['count_course'];
    countProduct = json['count_product'];
    expired = json['expired'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['count_item'] = this.countItem;
    data['count_course'] = this.countCourse;
    data['count_product'] = this.countProduct;
    data['expired'] = this.expired;
    data['created'] = this.created;
    return data;
  }
}
