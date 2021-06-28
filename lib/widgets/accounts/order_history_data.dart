import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/detail_order.dart';
import 'package:tsi_mobile/models/order_history.dart';
import 'package:tsi_mobile/pages/order/payment_confimation.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/accounts/order_products_item.dart';
import 'package:tsi_mobile/widgets/pasien/button.dart';

class OrderHistoryData extends StatefulWidget {
  final bool expanded;
  final bool showButton;
  final OrderHistory orderHistory;
  final List<CourseDetail> course;
  final List<Product> product;

  const OrderHistoryData(
      {Key key,
      this.expanded,
      this.orderHistory,
      this.course,
      this.product,
      this.showButton})
      : super(key: key);

  @override
  _OrderHistoryDataState createState() => _OrderHistoryDataState();
}

class _OrderHistoryDataState extends State<OrderHistoryData> {
  OrderHistory orderHistory = OrderHistory();
  List<CourseDetail> course = [];
  List<Product> product = [];

  Map<String, dynamic> receiptJson;

  Map<String, dynamic> shippingMethod;

  Widget generateStatus(String status, String receipt) {
    if (status == "1" && receipt != null) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
            margin: EdgeInsets.only(top: 8.sp, bottom: 10.sp),
            decoration: BoxDecoration(
                color: primary4.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10.sp)),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.library_add_check_rounded,
                  color: primary1,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Text(
                  "Sudah Melakukan Konfirmasi",
                  style: ralewayTextStyle.copyWith(
                      color: primary1, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Text(
            "(Pembayaran Sedang Dicek Sistem)",
            style:
                ralewayTextStyle.copyWith(color: Colors.red, fontSize: 12.sp),
          ),
          SizedBox(height: 10.sp)
        ],
      );
    }
    if (status == "2") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
        margin: EdgeInsets.only(top: 8.sp, bottom: 10.sp),
        decoration: BoxDecoration(
            color: primary1, borderRadius: BorderRadius.circular(10.sp)),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 18.sp,
            ),
            SizedBox(
              width: 5.sp,
            ),
            Text(
              "Sudah Lunas",
              style: ralewayTextStyle.copyWith(
                  color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }
    if (status == "4") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
        margin: EdgeInsets.only(top: 8.sp, bottom: 10.sp),
        decoration: BoxDecoration(
            color: primary4.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.sp)),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: primary1,
              size: 18.sp,
            ),
            SizedBox(
              width: 5.sp,
            ),
            Text(
              "Dikirim",
              style:
                  ralewayTextStyle.copyWith(color: primary1, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }
    if (status == "5") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
        margin: EdgeInsets.only(top: 8.sp, bottom: 10.sp),
        decoration: BoxDecoration(
          color: primary1,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: primary1,
              size: 18.sp,
            ),
            SizedBox(
              width: 5.sp,
            ),
            Text(
              "Sampai",
              style:
                  ralewayTextStyle.copyWith(color: primary1, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
      margin: EdgeInsets.only(top: 8.sp, bottom: 10.sp),
      decoration: BoxDecoration(
          color: secondary5.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.sp)),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: secondary1,
            size: 18.sp,
          ),
          SizedBox(
            width: 5.sp,
          ),
          Text(
            "Menunggu Pembayaran",
            style:
                ralewayTextStyle.copyWith(color: secondary1, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget renderButton(String status, String receipt) {
    if (status == "1" && receipt != null) {
      return ButtonPasien(
        onTap: () {},
        boxDecoration: BoxDecoration(
            color: secondary1, borderRadius: BorderRadius.circular(20.sp)),
        textStyle:
            ralewayTextStyle.copyWith(fontSize: 12.sp, color: Colors.white),
        title: "Cek Status Pembayaran",
      );
    }
    if (status == "2") {
      return ButtonPasien(
        onTap: () {},
        icon: Icon(
          FontAwesome.truck,
          size: 20.sp,
          color: Colors.white,
        ),
        boxDecoration: BoxDecoration(
            color: secondary1, borderRadius: BorderRadius.circular(20.sp)),
        textStyle:
            ralewayTextStyle.copyWith(fontSize: 12.sp, color: Colors.white),
        title: "Lacak Kiriman",
      );
    }
    return ButtonPasien(
      onTap: () {
        Get.to(
          PaymentConfirmationScreen(
            orderId: orderHistory.orderId.toString(),
          ),
        );
      },
      boxDecoration: BoxDecoration(
          color: secondary1, borderRadius: BorderRadius.circular(20.sp)),
      textStyle:
          ralewayTextStyle.copyWith(fontSize: 12.sp, color: Colors.white),
      title: "Konfirmasi Pembayaran",
    );
  }

  @override
  void initState() {
    course = widget.course;
    product = widget.product;
    orderHistory = widget.orderHistory;

    receiptJson = widget.orderHistory.receipt != null
        ? jsonDecode(widget.orderHistory.receipt)
        : null;
    shippingMethod = widget.orderHistory.carrier != null
        ? jsonDecode(widget.orderHistory.carrier)
        : null;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OrderHistoryData oldWidget) {
    course = widget.course;
    product = widget.product;
    orderHistory = widget.orderHistory;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final address = orderHistory.address != null
        ? jsonDecode(orderHistory?.address ?? "")
        : "";
    final payment = orderHistory.payment != null
        ? jsonDecode(orderHistory?.payment ?? "")
        : "";

    return AnimatedCrossFade(
      firstChild: Divider(),
      secondChild: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Status",
              style: ralewayTextStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            generateStatus(orderHistory.status, orderHistory.receipt),
            Divider(),
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Alamat Pengiriman",
              style: ralewayTextStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            Text(
              address["name"] ?? "",
              style: ralewayTextStyle.copyWith(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              address["phone"] ?? "",
              style: ralewayTextStyle.copyWith(
                color: textDark3,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              address["address"] ?? "",
              style: ralewayTextStyle.copyWith(
                color: textDark3,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Divider(),
            //pengiriman
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Metode Pengiriman",
              style: ralewayTextStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            if (shippingMethod != null)
              Text(
                "${shippingMethod["name"] ?? ""} (${currencyFormatExtension(shippingMethod["cost"]?.toString() ?? "")})",
                style: ralewayTextStyle.copyWith(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            if (shippingMethod != null)
              SizedBox(
                height: 10.sp,
              ),
            if (shippingMethod != null)
              Text(
                "Estimasi Tiba ${shippingMethod["etd"] ?? ""} hari",
                style: ralewayTextStyle.copyWith(
                  color: textDark2,
                  fontSize: 14.sp,
                ),
              ),
            SizedBox(
              height: 15.sp,
            ),
            Divider(),
            //payment methode
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Metode Pembayaran",
              style: ralewayTextStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            Text(
              payment["name"] ?? "",
              style: ralewayTextStyle.copyWith(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),

            Text(
              "Nomor Rekening",
              style: ralewayTextStyle.copyWith(
                color: textDark3,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    payment["nomor"] ?? "",
                    style: ralewayTextStyle.copyWith(
                        color: textDark2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                        new ClipboardData(text: payment["nomor"] ?? ""));
                  },
                  child: Text(
                    "salin",
                    style: ralewayTextStyle.copyWith(
                        color: primary1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18.sp,
            ),
            Text(
              "Jumlah Pembayaran",
              style: ralewayTextStyle.copyWith(
                color: textDark3,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    currencyFormatExtension((int.parse(orderHistory.total) +
                            int.parse((orderHistory.uniq ?? "0")))
                        .toString()),
                    style: ralewayTextStyle.copyWith(
                        color: primary1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(
                        text: (int.parse(orderHistory.total) +
                                int.parse((orderHistory.uniq ?? "0")))
                            .toString()));
                  },
                  child: Text(
                    "salin",
                    style: ralewayTextStyle.copyWith(
                        color: primary1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            if (receiptJson != null)
              SizedBox(
                height: 18.sp,
              ),
            if (receiptJson != null)
              Text(
                "Bukti Pembayaran",
                style: ralewayTextStyle.copyWith(
                  color: textDark3,
                  fontSize: 14.sp,
                ),
              ),
            if (receiptJson != null)
              SizedBox(
                height: 5.sp,
              ),
            if (receiptJson != null)
              Image.network(
                receiptJson["file"],
                width: 120.sp,
                fit: BoxFit.contain,
              ),
            SizedBox(
              height: 15.sp,
            ),
            Divider(),
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Metode Pembayaran",
              style: ralewayTextStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            Text(
              "Pelatihan (${course.length})",
              style: ralewayTextStyle.copyWith(
                color: primary1,
                fontSize: 14.sp,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10.sp),
                child: OrderProductItem(
                  imageUrl: course[index].image.first.file,
                  name: course[index].name,
                  total: course[index].total,
                ),
              ),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: course.length,
            ),
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Produk (${product.length})",
              style: ralewayTextStyle.copyWith(
                color: primary1,
                fontSize: 14.sp,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10.sp),
                child: OrderProductItem(
                  imageUrl: product[index].image.first.file,
                  name: product[index].name,
                  total: product[index].total,
                ),
              ),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: product.length,
            ),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Harga (${course.length + product.length}) Barang",
                      style: ralewayTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Text(
                      currencyFormatExtension((int.parse(orderHistory.total) +
                              int.parse((orderHistory.uniq ?? "0")))
                          .toString()),
                      style: ralewayTextStyle.copyWith(
                        color: primary1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                  ],
                )),
                SizedBox(
                  width: 10.sp,
                ),
                if (widget.showButton)
                  renderButton(orderHistory.status, orderHistory.receipt),
              ],
            ),
            SizedBox(
              height: 15.sp,
            ),
            Divider(),
          ],
        ),
      ),
      crossFadeState: !widget.expanded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 300),
    );
  }
}
