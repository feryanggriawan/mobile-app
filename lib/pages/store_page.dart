import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/pages/order/cart.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  bool isLoad = true;

  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgLight3,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16.h,
              ),
              buildSearchField(),
              SizedBox(
                height: 25.h,
              ),
              buildTabBar(),
              buildBody(),
            ],
          ),
        ));
  }

  Container buildSearchField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        children: [
          Expanded(
            child: Material(
              elevation: 0.8,
              shadowColor: Colors.grey.withOpacity(0.03),
              borderRadius: BorderRadius.circular(100.r),
              child: TextField(
                onChanged: (value) => print(value),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide: BorderSide(color: Colors.white)),
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Cari Pelatihan atau Produk...",
                    hintStyle: ralewayTextStyle.copyWith(
                        fontSize: 12.sp, color: textDark3),
                    suffixIcon: Container(
                        padding: EdgeInsets.all(9.w),
                        margin: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                            color: secondary1,
                            borderRadius: BorderRadius.circular(100.r)),
                        child: Icon(
                          UniconsLine.search,
                          size: 14.sp,
                          color: textLight2,
                        ))),
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          IconBtnWithCounter(
            onTap: () {
              context.read<CartCubit>().getCart(
                  (context.read<UserCubit>().state as UserLoaded)
                      .user
                      .id
                      .toString());
              Get.to(CartScreen());
            },
            backgroundColor: Colors.white,
            icon: UniconsLine.shopping_cart,
            numOfItems: (context.read<CartCubit>().state is CartLoaded)
                ? ((context.read<CartCubit>().state as CartLoaded)
                            ?.order
                            ?.data
                            ?.cartCourse ??
                        0) +
                    ((context.read<CartCubit>().state as CartLoaded)
                            ?.order
                            ?.data
                            ?.cartProduct ??
                        0)
                : 0,
          )
        ],
      ),
    );
  }

  Container buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: primary1,
          unselectedLabelColor: textDark2,
          labelStyle: ralewayTextStyle.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
          labelColor: textDark1,
          controller: controller,
          tabs: [
            Tab(text: "Pelatihan"),
            Tab(text: "Produk"),
          ]),
    );
  }

  Expanded buildBody() {
    return Expanded(
      child: TabBarView(controller: controller, children: [
        StorePelatihanPage(),
        StoreProdukPage(),
      ]),
    );
  }
}
