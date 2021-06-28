import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/pages/product_pages/detail_product_page.dart';

import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';

import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreProdukPage extends StatefulWidget {
  @override
  _StoreProdukPageState createState() => _StoreProdukPageState();
}

class _StoreProdukPageState extends State<StoreProdukPage> {
  int selectedIndex;
  int selectedId;

  final categoryCubit = CategoryCubit();

  final productCubit = ProductCubit();

  @override
  void initState() {
    categoryCubit.getAllCategory("");
    getProduct();
    super.initState();
  }

  getProduct() {
    if (selectedId != null) {
      return productCubit.getProductsCategory(selectedId.toString());
    }
    return productCubit.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [SizedBox(height: 16.sp), buildProduk()],
      ),
    );
  }

  Column buildProduk() {
    return Column(
      children: [
        BlocBuilder(
          cubit: categoryCubit,
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return CustomTabBarWidget(
                titles: state.products.map<String>((e) => e.title).toList(),
                selectedIndex: selectedIndex,
                onTap: (index) {
                  if (index == selectedIndex) {
                    setState(() {
                      selectedIndex = null;
                      selectedId = null;
                    });
                  } else {
                    setState(() {
                      selectedIndex = index;
                      selectedId = state.products[index].id;
                    });
                  }

                  getProduct();
                },
              );
            }
            return Container();
          },
        ),
        BlocBuilder(
          cubit: productCubit,
          builder: (_, state) {
            if (state is ProductLoaded) {
              if (state.products != null) {
                return GridView.builder(
                    itemCount: state.products.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin, vertical: 24.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: defaultMargin,
                      crossAxisSpacing: defaultMargin,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (_, index) {
                      if (state.products.length != 0) {
                        return GestureDetector(
                          child: Container(
                            height: 235.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24.r)),
                                  child: FadeInImage(
                                    height: 113.w,
                                    width: 156.w,
                                    placeholder: AssetImage(
                                        "assets/images/placeholder.jpg"),
                                    image: NetworkImage(
                                      state.products[index].images[0].file,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.products[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            playfairDisplayTextStyle.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp,
                                                color: textDark1),
                                      ),
                                      SizedBox(height: 8.w),
                                      (state.products[index].isDiscount)
                                          ? Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.w,
                                                      horizontal: 8.w),
                                                  decoration: BoxDecoration(
                                                      color: secondary6,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.r)),
                                                  child: Text(
                                                    "Disc",
                                                    style: ralewayTextStyle
                                                        .copyWith(
                                                            fontSize: 8.sp,
                                                            color: secondary1),
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                      "${state.products[index].basePrice}",
                                                      style: ralewayTextStyle
                                                          .copyWith(
                                                              color: textDark3,
                                                              fontSize: 8.sp,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      SizedBox(height: 4.w),
                                      Text(
                                        " ${currencyFormatExtension(state.products[index].price)}",
                                        style: ralewayTextStyle.copyWith(
                                          color: primary1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10.w),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: ButtonIconWidget(
                                          height: 28.w,
                                          label: Text(" Masuk Keranjang",
                                              style: ralewayTextStyle.copyWith(
                                                  color: bgLight2,
                                                  fontSize: 8.sp)),
                                          iconLeft: Icon(
                                            UniconsLine.shopping_cart,
                                            size: 10.sp,
                                            color: textLight2,
                                          ),
                                          onTap: () {
                                            context.read<CartCubit>().addProduct(
                                              userId: (context.read<UserCubit>().state as UserLoaded)
                                                  .user
                                                  .id
                                                  .toString(),
                                              productId: state.products[index].id.toString(),
                                              qty: "1",
                                              variant: state.products[index].variant.isNotEmpty ? state.products[index].variant.first.id.toString() : "",
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.to(
                              DetailProductPage(
                                state.products[index],
                              ),
                            );
                          },
                        );
                      } else {
                        return SizedBox();
                      }
                    });
              } else {
                return SizedBox();
              }
            } else if (state is ProductLoadingFailed) {
              if (state.code >= 500) {
                return Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Text("Gagal terhubung, \nsilahkan refresh ulang",
                        textAlign: TextAlign.center,
                        style: ralewayTextStyle.copyWith(
                            fontSize: 13.sp,
                            color: error,
                            fontWeight: FontWeight.bold)));
              } else {
                return SizedBox();
              }
            } else {
              return loadingIndicator();
            }
          },
        ),
      ],
    );
  }
}
