import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/payment_method/payment_method_cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/detail_order.dart';
import 'package:tsi_mobile/models/payment_method.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/payment/confimation_section.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicons/unicons.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final String orderId;

  const PaymentConfirmationScreen({Key key, this.orderId}) : super(key: key);

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  final ScrollController controller = ScrollController();
  final getOrderCubit = OrderDetailCubit();
  OrderDetail orderDetail = OrderDetail();

  PaymentMethod paymentMethod;

  double pixels = 0;

  String token;

  Map<String, dynamic> receipt;

  bool isEnd = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });

    getOrderCubit.getOrderDetail(
      widget.orderId,
    );

    super.initState();
  }

  void setPaymentMethod(int id) {
    print(id);
    setState(() {
      paymentMethod =
          (context.read<PaymentMethodCubit>().state as PaymentMethodLoaded)
              .paymentMethods
              .singleWhere(
                (o) => o.id == id,
              );
    });
  }

  void onEnd() {
    final endDate = DateTime.parse(orderDetail.expired).millisecondsSinceEpoch;
    final now = DateTime.now().millisecondsSinceEpoch;

    if ((endDate - now < 0))
      setState(() {
        isEnd = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: getOrderCubit,
            listener: (context, state) {
              print(state);
              if (state is OrderDetailLoaded) {
                setState(() {
                  orderDetail = state.order;
                  receipt = state.order.receipt != null
                      ? jsonDecode(state.order.receipt)
                      : null;
                });

                onEnd();
                if (orderDetail.payment.isNotEmpty) {
                  setPaymentMethod(
                      jsonDecode(orderDetail.payment)["payment_id"]);
                }
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedAppbarWidget(
              firstTitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Konfirmasi",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pixels: pixels,
              secondSuffix: Container(),
              firstSuffix: Container(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Konfirmasi",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              showHideIn: 50.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: BlocBuilder(
                    cubit: getOrderCubit,
                    builder: (context, state) {
                      if (state is OrderDetailLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Batas Akhir Pembayaran",
                              style: ralewayTextStyle.copyWith(
                                color: textDark3,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    DateFormat("EEEE, dd MMM yyyy H:mm", "id")
                                        .format(
                                      DateTime.parse(orderDetail.expired),
                                    ),
                                    style: ralewayTextStyle.copyWith(
                                      color: textDark2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                if (receipt == null)
                                  CountdownTimer(
                                    endTime: DateTime.parse(orderDetail.expired)
                                        .millisecondsSinceEpoch,
                                    textStyle: ralewayTextStyle.copyWith(
                                      color: secondary1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                    endWidget: Text(
                                      "Batas Waktu Habis",
                                      style: ralewayTextStyle.copyWith(
                                        color: textDark3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            if (receipt != null)
                              Text(
                                "Sudah Melakukan Konfirmasi Pada",
                                style: ralewayTextStyle.copyWith(
                                  color: primary1,
                                  fontSize: 14.sp,
                                ),
                              ),
                            SizedBox(
                              height: 5.w,
                            ),
                            if (receipt != null)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      DateFormat("EEEE, dd MMM yyyy", "id")
                                          .format(
                                        DateTime.parse(receipt["date"]),
                                      ),
                                      style: ralewayTextStyle.copyWith(
                                        color: textDark2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 8.w,
                            ),
                            Divider(),
                            SizedBox(
                              height: 8.w,
                            ),
                            Text(
                              "Nomor Rekening",
                              style: ralewayTextStyle.copyWith(
                                color: textDark3,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    paymentMethod.nomor,
                                    style: ralewayTextStyle.copyWith(
                                      color: textDark2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(new ClipboardData(
                                        text: paymentMethod.nomor));
                                  },
                                  child: Text(
                                    "Salin",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: primary1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            Text(
                              "Total Pembayaran",
                              style: ralewayTextStyle.copyWith(
                                color: textDark3,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    currencyFormatExtension(
                                        (int.parse(orderDetail.total) +
                                                int.parse(orderDetail.uniq))
                                            .toString()),
                                    style: ralewayTextStyle.copyWith(
                                      color: secondary1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    buildBottomSheet(
                                        title: "Detail Total Pembayaran");
                                  },
                                  child: Text(
                                    "Detail",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: primary1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return SpinKitCircle(
                        color: primary1,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: secondary1,
                  ),
                  borderRadius: BorderRadius.circular(20.sp)),
              padding: EdgeInsets.symmetric(
                vertical: 10.sp,
                horizontal: 2.sp,
              ),
              margin: EdgeInsets.only(bottom: 10.sp, left: 20.sp, right: 20.sp),
              child: GestureDetector(
                onTap: () {
                  Get.offAll(MainPage());
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belanja Lagi",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 12.sp, color: secondary1),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: isEnd
                      ? secondary7
                      : receipt == null
                          ? secondary1
                          : secondary7,
                  borderRadius: BorderRadius.circular(20.sp)),
              padding: EdgeInsets.symmetric(
                vertical: 10.sp,
                horizontal: 2.sp,
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 10.sp,
                  left: 20.sp,
                  right: 20.sp),
              child: GestureDetector(
                onTap: () {
                  if (!isEnd) {
                    if (receipt == null)
                      buildPaymentConfirmation();
                    else
                      buildPaymentConfirmation();
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Konfirmasi Pembayaran",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: isEnd
                              ? secondary1
                              : receipt == null
                                  ? Colors.white
                                  : secondary1),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder buildRoundedRectangleBorder() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)));
  }

  void buildBottomSheet({String title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: buildRoundedRectangleBorder(),
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 20.h,
                    left: defaultMargin,
                    right: defaultMargin),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(UniconsLine.multiply),
                      onTap: () => Get.back(),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      title,
                      style: header1Style.copyWith(
                          fontSize: 16.sp, color: primary1),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (orderDetail.data.product.isNotEmpty)
                      Text(
                        "Produk",
                        style: ralewayTextStyle.copyWith(
                          fontSize: 14.sp,
                          color: secondary1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    if (orderDetail.data.product.isNotEmpty)
                      Column(
                        children: orderDetail.data.product
                            .map(
                              (e) => Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.name,
                                            style: ralewayTextStyle.copyWith(
                                              fontSize: 14.sp,
                                              color: textDark2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Text(
                                            "${e.qty} x ${currencyFormatExtension(e.total)}",
                                            style: ralewayTextStyle.copyWith(
                                              fontSize: 14.sp,
                                              color: textDark3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${currencyFormatExtension(e.total)}",
                                      style: ralewayTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        color: textDark2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(bottom: 8.sp),
                              ),
                            )
                            .toList(),
                      ),
                    if (orderDetail.data.course.isNotEmpty)
                      Text(
                        "Produk",
                        style: ralewayTextStyle.copyWith(
                          fontSize: 14.sp,
                          color: secondary1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (orderDetail.data.course.isNotEmpty)
                      Column(
                        children: orderDetail.data.course
                            .map(
                              (e) => Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.name,
                                            style: ralewayTextStyle.copyWith(
                                              fontSize: 14.sp,
                                              color: textDark2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Text(
                                            "${e.qty} x ${currencyFormatExtension(e.total)}",
                                            style: ralewayTextStyle.copyWith(
                                              fontSize: 14.sp,
                                              color: textDark3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${currencyFormatExtension(e.total)}",
                                      style: ralewayTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        color: textDark2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(bottom: 8.sp),
                              ),
                            )
                            .toList(),
                      ),
                    Divider(
                      height: 30.w,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total Harga (${orderDetail.data.course.length + orderDetail.data.product.length} Barang)",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: textDark2,
                              ),
                            ),
                          ),
                          Text(
                            "${currencyFormatExtension(orderDetail.total)}",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 14.sp,
                              color: textDark2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 8.sp),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Ongkir",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: textDark2,
                              ),
                            ),
                          ),
                          Text(
                            "${currencyFormatExtension(orderDetail.shipping)}",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 14.sp,
                              color: textDark2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 8.sp),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Kode Unik",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: textDark2,
                              ),
                            ),
                          ),
                          Text(
                            "${orderDetail.uniq}",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 14.sp,
                              color: textDark2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 25.sp),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total Tagihan",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: textDark2,
                              ),
                            ),
                          ),
                          Text(
                            "${currencyFormatExtension((int.parse(orderDetail.uniq) + int.parse(orderDetail.total)).toString())}",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 14.sp,
                              color: primary1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void buildPaymentConfirmation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: buildRoundedRectangleBorder(),
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 20.h,
                    left: defaultMargin,
                    right: defaultMargin),
                child: ConfirmationSectionWidget(
                  orderId: widget.orderId,
                  bottomSheetContex: bc,
                  date: receipt["date"] ?? null,
                  image: receipt["file"] ?? null,
                  callBackFunction: () {
                    getOrderCubit.getOrderDetail(
                      widget.orderId,
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
