import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/carrier/carrier_cubit.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/get_delivery_carrier/get_delivery_carrier_cubit.dart';
import 'package:tsi_mobile/cubit/set_carrier/set_carrier_cubit.dart';
import 'package:tsi_mobile/cubit/set_delivery_address/set_delivery_address_cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/delivery_address.dart';
import 'package:tsi_mobile/models/delivery_carrier.dart';
import 'package:tsi_mobile/pages/order/payment_method.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/checkout/header_seperator.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicons/unicons.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ScrollController controller = ScrollController();
  final deliveryCarrier = GetDeliveryCarrierCubit();
  final deliveryCubit = SetDeliveryAddressCubit();
  final setCarrierCubit = SetCarrierCubit();
  DeliveryAddress deliveryAddress;

  double pixels = 0;

  String serviceId;

  Costs resultsCarrier;
  String service = "";

  String total = "0";

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });

    deliveryCubit.deliveryAddress(body: {
      "order": (context.read<CartCubit>().state as CartLoaded).order.orderId,
      "name": (context.read<UserCubit>().state as UserLoaded).user.name,
      "phone": (context.read<UserCubit>().state as UserLoaded).user.phone,
      "address": (context.read<UserCubit>().state as UserLoaded).user.address,
      "location": (context.read<UserCubit>().state as UserLoaded).user.location,
    });

    // countTotal();

    super.initState();
  }

  Future<String> setServiceId(String serviceType, String carrier) async {
    String id;

    print("$carrier-$serviceType");

    id = (context.read<CarrierCubit>().state as CarriersLoaded)
        .carriers
        .singleWhere(
          (o) => o.slug == "$carrier-$serviceType",
        )
        .id
        .toString();

    setState(() {
      serviceId = id;
    });

    return serviceId;
  }

  int countTotal() {
    int _total = 0;

    _total = countCartProductTotal() +
        countCartCourseTotal() +
        resultsCarrier.cost.first.value;

    setState(() {
      total = _total.toString();
    });
    return _total;
  }

  int countCartProductTotal() {
    int _total = 0;

    (context.read<CartCubit>().state as CartLoaded)
        .order
        .data
        .product
        .forEach((element) {
      _total = _total + int.parse(element.total);
    });

    return _total;
  }

  int countCartCourseTotal() {
    int _total = 0;

    (context.read<CartCubit>().state as CartLoaded)
        .order
        .data
        .course
        .forEach((element) {
      _total = _total + int.parse(element.total);
    });

    return _total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartLoaded) {
                countTotal();
              }
            },
          ),
          BlocListener(
            cubit: setCarrierCubit,
            listener: (context, state) {
              if (state is SetCarrierLoaded) {
                countTotal();
              }
            },
          ),
          BlocListener(
            listener: (context, state) {
              if (state is SetDeliveryAddressLoaded)
                setState(() {
                  deliveryAddress = state.deliveryAddress;
                });

              deliveryCarrier.getDeliveryCarrier(
                order: (context.read<CartCubit>().state as CartLoaded)
                    .order
                    .orderId
                    .toString(),
              );
            },
            cubit: deliveryCubit,
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
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderSeperatorCheckout(
                        onTap: () {},
                        title: "Alamat Pengiriman",
                        buttonTitle: "Pilih Alamat Lainnya",
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      BlocBuilder(
                        builder: (context, state) {
                          if (state is SetDeliveryAddressInitial) {
                            return SpinKitCircle(
                              color: primary1,
                            );
                          }
                          if (state is SetDeliveryAddressLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.deliveryAddress.name,
                                  style: ralewayTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.sp,
                                ),
                                Text(
                                  state.deliveryAddress.phone,
                                  style: ralewayTextStyle.copyWith(),
                                ),
                                SizedBox(
                                  height: 6.sp,
                                ),
                                Text(
                                  state.deliveryAddress.address,
                                  style: ralewayTextStyle.copyWith(color: grey),
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                        cubit: deliveryCubit,
                      ),
                      Divider(
                        height: 20.sp,
                      ),
                      HeaderSeperatorCheckout(
                        onTap: () {
                          buildBottomSheet(title: "Pilih Pengiriman");
                        },
                        title: "Metode Pengiriman",
                        buttonTitle: "Pilih Pengiriman",
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      if (resultsCarrier != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text(
                                  service.toUpperCase(),
                                  style: ralewayTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  resultsCarrier.service.toUpperCase(),
                                  style: ralewayTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "(${currencyFormatExtension(resultsCarrier.cost.first.value.toString())})",
                                  style: ralewayTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Estimasi Tiba ${resultsCarrier.cost.first.etd} Hari",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                          ],
                        )
                      else
                        Text(
                          "Belum Dipilih",
                          style: ralewayTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Divider(),
                      SizedBox(
                        height: 15.sp,
                      ),
                      HeaderSeperatorCheckout(
                        title: "Pesanan",
                        buttonTitle: "Pilih Pengiriman",
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Pelatihan (${(context.read<CartCubit>().state is CartLoaded) ? (context.read<CartCubit>().state as CartLoaded)?.order?.data?.course?.length ?? 0 : 0})",
                        style: playfairDisplayTextStyle.copyWith(
                          color: primary1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (context.read<CartCubit>().state
                                is CartLoaded)
                            ? (context.read<CartCubit>().state as CartLoaded)
                                    ?.order
                                    ?.data
                                    ?.course
                                    ?.map(
                                  (prod) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 15.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            prod.image.first.file,
                                            height: 80.sp,
                                            width: 80.sp,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 10.sp,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${prod.name ?? ""}",
                                                  maxLines: 1,
                                                  style:
                                                      playfairDisplayTextStyle
                                                          .copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (int.parse(
                                                            prod.discount) >
                                                        0)
                                                      Container(
                                                        child: Text(
                                                          "Disc",
                                                          style:
                                                              playfairDisplayTextStyle
                                                                  .copyWith(
                                                            color: secondary1,
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 5.sp),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3.sp,
                                                                horizontal:
                                                                    8.sp),
                                                        decoration: BoxDecoration(
                                                            color: secondary4
                                                                .withOpacity(
                                                                    0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp)),
                                                      ),
                                                    if (int.parse(
                                                            prod.discount) >
                                                        0)
                                                      Expanded(
                                                        child: Text(
                                                          currencyFormatExtension(
                                                              prod.subtotal),
                                                          style:
                                                              playfairDisplayTextStyle
                                                                  .copyWith(
                                                            color: grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationThickness:
                                                                8.sp,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    Spacer(),
                                                    GestureDetector(
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                        size: 18.sp,
                                                      ),
                                                      onTap: () => (context
                                                          .read<CartCubit>()
                                                          .deleteCart(
                                                            (context
                                                                        .read<
                                                                            UserCubit>()
                                                                        .state
                                                                    as UserLoaded)
                                                                .user
                                                                .id
                                                                .toString(),
                                                            prod.cartId
                                                                .toString(),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.sp,
                                                ),
                                                Text(
                                                  currencyFormatExtension(
                                                      prod.subtotal),
                                                  style:
                                                      playfairDisplayTextStyle
                                                          .copyWith(
                                                    color: primary1,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )?.toList() ??
                                []
                            : [],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Produk (${(context.read<CartCubit>().state is CartLoaded) ? (context.read<CartCubit>().state as CartLoaded)?.order?.data?.product?.length ?? 0 : 0})",
                        style: playfairDisplayTextStyle.copyWith(
                          color: primary1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (context.read<CartCubit>().state
                                is CartLoaded)
                            ? (context.read<CartCubit>().state as CartLoaded)
                                    ?.order
                                    ?.data
                                    ?.product
                                    ?.map(
                                  (prod) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 15.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            prod.image.first.file,
                                            height: 80.sp,
                                            width: 80.sp,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 10.sp,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${prod.name ?? ""}",
                                                  maxLines: 1,
                                                  style:
                                                      playfairDisplayTextStyle
                                                          .copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (int.parse(
                                                            prod.discount) >
                                                        0)
                                                      Container(
                                                        child: Text(
                                                          "Disc",
                                                          style:
                                                              playfairDisplayTextStyle
                                                                  .copyWith(
                                                            color: secondary1,
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 5.sp),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3.sp,
                                                                horizontal:
                                                                    8.sp),
                                                        decoration: BoxDecoration(
                                                            color: secondary4
                                                                .withOpacity(
                                                                    0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp)),
                                                      ),
                                                    if (int.parse(
                                                            prod.discount) >
                                                        0)
                                                      Expanded(
                                                        child: Text(
                                                          currencyFormatExtension(
                                                              prod.subtotal),
                                                          style:
                                                              playfairDisplayTextStyle
                                                                  .copyWith(
                                                            color: grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationThickness:
                                                                8.sp,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    Spacer(),
                                                    GestureDetector(
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                        size: 18.sp,
                                                      ),
                                                      onTap: () => (context
                                                          .read<CartCubit>()
                                                          .deleteCart(
                                                            (context
                                                                        .read<
                                                                            UserCubit>()
                                                                        .state
                                                                    as UserLoaded)
                                                                .user
                                                                .id
                                                                .toString(),
                                                            prod.cartId
                                                                .toString(),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.sp,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        currencyFormatExtension(
                                                            prod.total),
                                                        style:
                                                            playfairDisplayTextStyle
                                                                .copyWith(
                                                          color: primary1,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: CircleAvatar(
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 10.sp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            backgroundColor:
                                                                secondary1,
                                                            radius: 9.sp,
                                                          ),
                                                          onTap: () => (context
                                                              .read<CartCubit>()
                                                              .changeCartQuantity(
                                                                cart: prod
                                                                    .cartId
                                                                    .toString(),
                                                                qty: (int.parse(
                                                                            prod.qty) +
                                                                        1)
                                                                    .toString(),
                                                                userId: (context
                                                                        .read<
                                                                            UserCubit>()
                                                                        .state as UserLoaded)
                                                                    .user
                                                                    .id
                                                                    .toString(),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        Text(prod.qty),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        GestureDetector(
                                                          child: CircleAvatar(
                                                            child: Text(
                                                              "-",
                                                              style:
                                                                  ralewayTextStyle
                                                                      .copyWith(
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                int.parse(prod
                                                                            .qty) >
                                                                        1
                                                                    ? secondary1
                                                                    : secondary6,
                                                            radius: 9.sp,
                                                          ),
                                                          onTap: () {
                                                            if (int.parse(
                                                                    prod.qty) >
                                                                1) {
                                                              context
                                                                  .read<
                                                                      CartCubit>()
                                                                  .changeCartQuantity(
                                                                    cart: prod
                                                                        .cartId
                                                                        .toString(),
                                                                    qty: (int.parse(prod.qty) -
                                                                            1)
                                                                        .toString(),
                                                                    userId: (context
                                                                            .read<UserCubit>()
                                                                            .state as UserLoaded)
                                                                        .user
                                                                        .id
                                                                        .toString(),
                                                                  );
                                                            } else {
                                                              context
                                                                  .read<
                                                                      CartCubit>()
                                                                  .deleteCart(
                                                                    (context.read<UserCubit>().state
                                                                            as UserLoaded)
                                                                        .user
                                                                        .id
                                                                        .toString(),
                                                                    prod.cartId
                                                                        .toString(),
                                                                  );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )?.toList() ??
                                []
                            : [],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomCartSection(
              total: total,
              onTap: () {
                Get.to(
                  PaymentMethodScreen(total: total),
                );
              },
              buttonTitle: "Pilih Pembayaran",
            )
          ],
        ),
      ),
    );
  }

  void setCarrier(Costs carrier, String selectedService) async {
    setState(() {
      service = selectedService;
      resultsCarrier = carrier;
    });

    await setServiceId(
        resultsCarrier.service.toLowerCase(), selectedService.toLowerCase());

    setCarrierCubit.setCarrier(
        carrier: serviceId,
        order: (context.read<CartCubit>().state as CartLoaded)
            .order
            .orderId
            .toString());
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
                    StatefulBuilder(
                      builder: (context, setState) => BlocBuilder(
                        builder: (context, state) {
                          if (state is GetDeliveryCarrierLoaded)
                            return ListView.builder(
                              itemBuilder: (context, index) => ListView.builder(
                                itemBuilder: (context, i) => ListView.builder(
                                  itemBuilder: (context, n) => GestureDetector(
                                    onTap: () {
                                      setCarrier(
                                          state.deliveryCarries[index].ongkir
                                              .results[i].costs[n],
                                          state.deliveryCarries[index].ongkir
                                              .results[i].code);
                                      Get.back();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            Text(
                                              state.deliveryCarries[index]
                                                  .ongkir.results[i].code
                                                  .toUpperCase(),
                                              style: ralewayTextStyle.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              state
                                                  .deliveryCarries[index]
                                                  .ongkir
                                                  .results[i]
                                                  .costs[n]
                                                  .service,
                                              style: ralewayTextStyle.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "(${state.deliveryCarries[index].ongkir.results[i].costs[n].cost.first.etd} Hari)",
                                              style: ralewayTextStyle.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "(${currencyFormatExtension(
                                            state
                                                .deliveryCarries[index]
                                                .ongkir
                                                .results[i]
                                                .costs[n]
                                                .cost
                                                .first
                                                .value
                                                .toString(),
                                          )})",
                                          style: ralewayTextStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Divider(
                                          height: 30.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.deliveryCarries[index].ongkir
                                      .results[i].costs.length,
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.deliveryCarries[index].ongkir
                                    .results.length,
                              ),
                              itemCount: state.deliveryCarries.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                            );
                          return SizedBox();
                        },
                        cubit: deliveryCarrier,
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
}
