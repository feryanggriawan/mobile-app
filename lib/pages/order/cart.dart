import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/detail_order.dart';
import 'package:tsi_mobile/pages/order/checkout.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_mobile/widgets/cart/addition_pelatihan_cart.dart';
import 'package:tsi_mobile/widgets/cart/additional_product_cart.dart';
import 'package:tsi_mobile/widgets/cart/select_all_section.dart';
import 'package:tsi_mobile/widgets/cart/select_all_widget.dart';
import 'package:tsi_mobile/widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController controller = ScrollController();
  bool chooseAll = true;
  bool chooseAllTraining = true;
  bool chooseAllProducs = true;

  double pixels = 0;

  int total = 0;

  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> courses = [];
  List<Product> cartsProduct = [];
  List<CourseDetail> cartsCourseDetail = [];

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });

    super.initState();
  }

  void countData() {
    products.clear();
    courses.clear();
    cartsProduct.clear();
    cartsCourseDetail.clear();

    chooseAll = true;
    chooseAllTraining = true;
    chooseAllProducs = true;

    if (context.read<CartCubit>().state is CartLoaded) {
      ((context.read<CartCubit>().state as CartLoaded)?.order?.data?.product ??
              [])
          .forEach((element) {
        print(element);
        products.add({
          "check": true,
          "data": element.toJson(),
        });

        cartsProduct.add(element);

        print(cartsProduct.length);
      });

      ((context.read<CartCubit>().state as CartLoaded)?.order?.data?.course ??
              [])
          .forEach((element) {
        courses.add({
          "check": true,
          "data": element.toJson(),
        });

        cartsCourseDetail.add(element);
      });

      total = countTotal();
    }

    setState(() {});
  }

  int countTotal() {
    int _total = 0;

    _total = countCartProductTotal() + countCartCourseTotal();

    return _total;
  }

  int countCartProductTotal() {
    int _total = 0;

    cartsProduct.forEach((element) {
      _total = _total + int.parse(element.total);
    });

    return _total;
  }

  int countCartCourseTotal() {
    int _total = 0;

    cartsCourseDetail.forEach((element) {
      _total = _total + int.parse(element.total);
    });

    return _total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            listener: (context, state) {
              if (state is CartLoaded) {
                countData();
              }
            },
            cubit: context.read<CartCubit>(),
          ),
        ],
        child: BlocBuilder(
          cubit: context.read<CartCubit>(),
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderCart(
                  pixels: pixels,
                ),
                if (state is CartLoadingFailed)
                  Expanded(
                    child: SizedBox(),
                  ),
                if (state is CartLoaded)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.sp, vertical: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CartSelectAllWidget(
                              onChanged: (v) {
                                print(products.length);
                                print(cartsProduct.length);
                                courses.map((e) {
                                  final CourseDetail prod =
                                      CourseDetail.fromJson(e["data"]);

                                  if (v) {
                                    setState(() {
                                      cartsCourseDetail.add(prod);
                                    });
                                  } else {
                                    setState(() {
                                      cartsCourseDetail
                                          .removeAt(courses.indexOf(e));
                                    });
                                  }
                                  e["check"] = !e["check"];
                                }).toList();
                                products.map((e) {
                                  print(e);
                                  final Product prod =
                                      Product.fromJson(e["data"]);

                                  if (v) {
                                    setState(() {
                                      cartsProduct.add(prod);
                                    });
                                  } else {
                                    setState(() {
                                      cartsProduct
                                          .removeAt(products.indexOf(e));
                                    });
                                  }
                                  e["check"] = !e["check"];
                                }).toList();
                                setState(() {
                                  chooseAll = v;
                                  chooseAllProducs = v;
                                  chooseAllTraining = v;
                                  total = countTotal();
                                });
                              },
                              chooseAll: chooseAll,
                              onDelete: () {
                                products.map((e) {
                                  final Product prod =
                                      Product.fromJson(e["data"]);
                                  context.read<CartCubit>().deleteCart(
                                        (context.read<UserCubit>().state
                                                as UserLoaded)
                                            .user
                                            .id
                                            .toString(),
                                        prod.cartId.toString(),
                                      );
                                }).toList();
                                courses.map((e) {
                                  final CourseDetail prod =
                                      CourseDetail.fromJson(e["data"]);
                                  context.read<CartCubit>().deleteCart(
                                        (context.read<UserCubit>().state
                                                as UserLoaded)
                                            .user
                                            .id
                                            .toString(),
                                        prod.cartId.toString(),
                                      );
                                }).toList();
                                setState(() {
                                  chooseAll = false;
                                  chooseAllProducs = false;
                                  chooseAllTraining = false;
                                  cartsProduct.clear();
                                  courses.clear();
                                  products.clear();
                                  cartsProduct.clear();
                                  total = countTotal();
                                });
                              },
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            if (courses.isNotEmpty)
                              SelectAllSectionWidget(
                                onChanged: (v) {
                                  courses.map((e) {
                                    final CourseDetail prod =
                                        CourseDetail.fromJson(e["data"]);

                                    if (v) {
                                      setState(() {
                                        cartsCourseDetail.add(prod);
                                      });
                                    } else {
                                      setState(() {
                                        if (cartsCourseDetail.length == 1) {
                                          cartsCourseDetail.clear();
                                        } else {
                                          cartsCourseDetail
                                              .removeAt(products.indexOf(e));
                                        }
                                      });
                                    }
                                    e["check"] = !e["check"];
                                  }).toList();

                                  setState(() {
                                    chooseAllTraining = v;
                                    total = countTotal();
                                  });
                                },
                                title:
                                    "Pelatihan (${(context.read<CartCubit>().state as CartLoaded)?.order?.data?.cartCourse ?? 0})",
                                checkBoxValue: chooseAllTraining,
                              ),
                            if (courses.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: courses?.map(
                                      (e) {
                                        final CourseDetail prod =
                                            CourseDetail.fromJson(e["data"]);
                                        return Container(
                                          margin:
                                              EdgeInsets.only(bottom: 15.sp),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Checkbox(
                                                  value: e["check"],
                                                  onChanged: (v) {
                                                    if (v)
                                                      setState(() {
                                                        cartsCourseDetail
                                                            .add(prod);
                                                      });
                                                    else
                                                      setState(() {
                                                        cartsCourseDetail
                                                            .removeAt(courses
                                                                .indexOf(e));
                                                      });

                                                    setState(() {
                                                      e["check"] = v;
                                                      total = countTotal();
                                                    });
                                                  },
                                                  activeColor: primary1,
                                                ),
                                                width: 20.sp,
                                              ),
                                              SizedBox(
                                                width: 10.sp,
                                              ),
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
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                                color:
                                                                    secondary1,
                                                                fontSize: 8.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        5.sp),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        3.sp,
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
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red,
                                                            size: 18.sp,
                                                          ),
                                                          onTap: () => (context
                                                              .read<CartCubit>()
                                                              .deleteCart(
                                                                (context
                                                                        .read<
                                                                            UserCubit>()
                                                                        .state as UserLoaded)
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
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                    [],
                              ),
                            if (products.isNotEmpty)
                              SelectAllSectionWidget(
                                onChanged: (v) {
                                  products.map((e) {
                                    final Product prod =
                                        Product.fromJson(e["data"]);

                                    setState(() {
                                      e["check"] = !e["check"];
                                    });

                                    if (v) {
                                      setState(() {
                                        cartsProduct.add(prod);
                                      });
                                    } else {
                                      setState(() {
                                        if (cartsProduct.length == 1) {
                                          cartsProduct.clear();
                                        } else {
                                          cartsProduct
                                              .removeAt(products.indexOf(e));
                                        }
                                      });
                                    }
                                  }).toList();

                                  setState(() {
                                    chooseAllProducs = v;
                                    total = countTotal();
                                  });
                                },
                                title:
                                    "Produk (${(context.read<CartCubit>().state as CartLoaded)?.order?.data?.cartProduct ?? 0})",
                                checkBoxValue: chooseAllProducs,
                              ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            if (products.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: products?.map(
                                      (e) {
                                        final Product prod =
                                            Product.fromJson(e["data"]);
                                        return Container(
                                          margin:
                                              EdgeInsets.only(bottom: 15.sp),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Checkbox(
                                                  value: e["check"],
                                                  onChanged: (v) {
                                                    if (v)
                                                      setState(() {
                                                        cartsProduct.add(prod);
                                                      });
                                                    else
                                                      setState(() {
                                                        cartsProduct.removeAt(
                                                            products
                                                                .indexOf(e));
                                                      });

                                                    setState(() {
                                                      e["check"] = v;
                                                      total = countTotal();
                                                    });
                                                  },
                                                  activeColor: primary1,
                                                ),
                                                width: 20.sp,
                                              ),
                                              SizedBox(
                                                width: 10.sp,
                                              ),
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
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                                color:
                                                                    secondary1,
                                                                fontSize: 8.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        5.sp),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        3.sp,
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
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red,
                                                            size: 18.sp,
                                                          ),
                                                          onTap: () => (context
                                                              .read<CartCubit>()
                                                              .deleteCart(
                                                                (context
                                                                        .read<
                                                                            UserCubit>()
                                                                        .state as UserLoaded)
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
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              child:
                                                                  CircleAvatar(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 10.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                backgroundColor:
                                                                    secondary1,
                                                                radius: 9.sp,
                                                              ),
                                                              onTap: () => (context
                                                                  .read<
                                                                      CartCubit>()
                                                                  .changeCartQuantity(
                                                                    cart: prod
                                                                        .cartId
                                                                        .toString(),
                                                                    qty: (int.parse(prod.qty) +
                                                                            1)
                                                                        .toString(),
                                                                    userId: (context
                                                                            .read<UserCubit>()
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
                                                              child:
                                                                  CircleAvatar(
                                                                child: Text(
                                                                  "-",
                                                                  style: ralewayTextStyle
                                                                      .copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                backgroundColor:
                                                                    int.parse(prod.qty) >
                                                                            1
                                                                        ? secondary1
                                                                        : secondary6,
                                                                radius: 9.sp,
                                                              ),
                                                              onTap: () {
                                                                if (int.parse(prod
                                                                        .qty) >
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
                                                                        userId: (context.read<UserCubit>().state
                                                                                as UserLoaded)
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
                                    [],
                              ),
                            SizedBox(
                              height: 20.h,
                            ),
                            if (courses.isNotEmpty)
                              Text(
                                "Pelatihan Lainnya",
                                style: playfairDisplayTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    color: textDark1,
                                    fontWeight: FontWeight.w700),
                              ),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (courses.isNotEmpty)
                              BlocBuilder<CourseOfflineCubit,
                                  CourseOfflineState>(
                                builder: (_, state) {
                                  if (state is CourseOfflineLoaded) {
                                    if (state.coursesOffline != null) {
                                      return SizedBox(
                                          height: 125.h,
                                          child: ListView.builder(
                                              itemCount:
                                                  state.coursesOffline.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (_, index) {
                                                return BuildPelatihanCart(
                                                  index: index,
                                                  listPelatihan:
                                                      state.coursesOffline,
                                                );
                                              }));
                                    } else {
                                      return SizedBox();
                                    }
                                  } else if (state
                                      is CourseOfflineLoadingFailed) {
                                    if (state.code >= 500) {
                                      return Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Text(
                                              "Gagal terhubung, \nsilahkan refresh ulang",
                                              textAlign: TextAlign.center,
                                              style: ralewayTextStyle.copyWith(
                                                  fontSize: 13.sp,
                                                  color: error,
                                                  fontWeight:
                                                      FontWeight.bold)));
                                    } else {
                                      return SizedBox();
                                    }
                                  } else {
                                    return loadingIndicator();
                                  }
                                },
                              ),
                            SizedBox(
                              height: 20.h,
                            ),
                            if (products.isNotEmpty)
                              Text(
                                "Produk Lainnya",
                                style: playfairDisplayTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    color: textDark1,
                                    fontWeight: FontWeight.w700),
                              ),
                            SizedBox(
                              height: 15.h,
                            ),
                            if (products.isNotEmpty)
                              BlocBuilder<ProductCubit, ProductState>(
                                builder: (_, state) {
                                  if (state is ProductLoaded) {
                                    if (state.products != null) {
                                      return SizedBox(
                                        height: 180.h,
                                        child: ListView.builder(
                                          itemCount: state.products.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (_, index) {
                                            return AdditionalProductCart(
                                              onTap: () {
                                                context
                                                    .read<CartCubit>()
                                                    .addProduct(
                                                      userId: (context
                                                              .read<UserCubit>()
                                                              .state as UserLoaded)
                                                          .user
                                                          .id
                                                          .toString(),
                                                      productId: state
                                                          .products[index].id
                                                          .toString(),
                                                      qty: "1",
                                                      variant: state
                                                              .products[index]
                                                              .variant
                                                              .isNotEmpty
                                                          ? state
                                                              .products[index]
                                                              .variant
                                                              .first
                                                              .id
                                                              .toString()
                                                          : "",
                                                    );
                                              },
                                              productModel:
                                                  state.products[index],
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  } else if (state is ProductLoadingFailed) {
                                    if (state.code >= 500) {
                                      return Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Text(
                                              "Gagal terhubung, \nsilahkan refresh ulang",
                                              textAlign: TextAlign.center,
                                              style: ralewayTextStyle.copyWith(
                                                  fontSize: 13.sp,
                                                  color: error,
                                                  fontWeight:
                                                      FontWeight.bold)));
                                    } else {
                                      return SizedBox();
                                    }
                                  } else {
                                    return loadingIndicator();
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                BottomCartSection(
                  onTap: () => Get.to(CheckoutScreen()),
                  total: total.toString(),
                  iconData: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
