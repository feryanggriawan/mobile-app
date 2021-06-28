import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/checkout/checkout_cubit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/get_order/get_order_cubit.dart';
import 'package:tsi_mobile/cubit/payment_method/payment_method_cubit.dart';
import 'package:tsi_mobile/models/detail_order.dart';
import 'package:tsi_mobile/models/payment_method.dart';
import 'package:tsi_mobile/pages/order/payment_confimation.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/checkout/checkout_item_expanded.dart';
import 'package:tsi_mobile/widgets/payment/bottom_checkout_section.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  final String total;

  const PaymentScreen({Key key, this.total}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ScrollController controller = ScrollController();
  final getOrderCubit = GetOrderCubit();
  OrderDetail orderDetail = OrderDetail();
  final checkoutCubit = CheckoutCubit();
  String orderId = "";

  PaymentMethod paymentMethod;

  double pixels = 0;

  String token;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });

    getOrderCubit.getOrder(
      (context.read<UserCubit>().state as UserLoaded).user.id.toString(),
      (context.read<CartCubit>().state as CartLoaded).order.orderId.toString(),
    );

    orderId = (context.read<CartCubit>().state as CartLoaded)
        .order
        .orderId
        .toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: getOrderCubit,
            listener: (context, state) {
              print(state);
              if (state is GetOrderLoaded) {
                setState(() {
                  orderDetail = state.order;
                });

                if (orderDetail.payment.isNotEmpty) {
                  setPaymentMethod(
                      jsonDecode(orderDetail.payment)["payment_id"]);
                }
              }
            },
          ),
          BlocListener(
            cubit: checkoutCubit,
            listener: (context, state) {
              print(state);
              if (state is CheckoutLoaded) {
                context.read<CartCubit>().getCart(
                    (context.read<UserCubit>().state as UserLoaded)
                        .user
                        .id
                        .toString());
                Get.to(
                  PaymentConfirmationScreen(
                    orderId: orderId,
                  ),
                );
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
                          "Pembayaran",
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
                          "Pengiriman",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (orderDetail.orderId != null)
                        CheckoutItemExpanded(
                          order: orderDetail,
                        ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              paymentMethod?.name ?? "",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          Image.network(
                            paymentMethod?.image ?? "",
                            height: 30.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: textDark2,
                            radius: 5.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Text(
                              "Pastikan mengirim jumlah pembayaran sesuai dengan kode unik yang diberikan",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: textDark2,
                            radius: 5.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Text(
                              "Dapatkan kode pembayaran setelah klik “Bayar”.",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            BottomCheckoutSection(
              buttonTitle: "Bayar Sekarang",
              onTap: () {
                checkoutCubit.checkout(
                    (context.read<UserCubit>().state as UserLoaded)
                        .user
                        .id
                        .toString());
              },
              canNext: true,
            )
          ],
        ),
      ),
    );
  }
}
