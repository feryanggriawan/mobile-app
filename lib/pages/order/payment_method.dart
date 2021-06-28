import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/payment_method/payment_method_cubit.dart';
import 'package:tsi_mobile/cubit/set_payment_method/set_payment_method_cubit.dart';
import 'package:tsi_mobile/pages/order/payment.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/payment/bottom_payment_section.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String total;

  const PaymentMethodScreen({Key key, this.total}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final ScrollController controller = ScrollController();
  final paymentMethodCubit = SetPaymentMethodCubit();
  double pixels = 0;

  String token;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        cubit: paymentMethodCubit,
        listener: (context, state) {
          if (state is SetPaymentMethodLoaded) {
            Get.to(PaymentScreen());
          }
        },
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
                      Column(
                        children: (context.read<PaymentMethodCubit>().state
                                as PaymentMethodLoaded)
                            .paymentMethods
                            .map(
                              (e) => Row(
                                children: [
                                  Image.network(
                                    e.image,
                                    height: 30.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.name,
                                          style: ralewayTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.w,
                                        ),
                                        Text(
                                          e.description,
                                          style: ralewayTextStyle.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Radio<String>(
                                    value: e.token,
                                    activeColor: primary1,
                                    groupValue: token,
                                    onChanged: (String value) {
                                      setState(() {
                                        token = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder(
              builder: (context, state) {
                return BottomPaymentSection(
                  buttonTitle: "Lanjutkan Pembayaran",
                  total: widget.total,
                  onTap: () {
                    paymentMethodCubit.setPaymentMethod(
                      payment: token,
                      order: (context.read<CartCubit>().state as CartLoaded)
                          .order
                          .orderId
                          .toString(),
                    );
                  },
                  anotherCharge: "0",
                  canNext: token != null ? true : false,
                );
              },
              cubit: paymentMethodCubit,
            )
          ],
        ),
      ),
    );
  }
}
