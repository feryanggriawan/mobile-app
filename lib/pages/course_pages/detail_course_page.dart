import 'package:flutter/material.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/order/cart.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCoursePage extends StatelessWidget {
  final CourseModel course;

  DetailCoursePage(this.course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(expandedHeight: 370, course: course),
                pinned: true,
              ),
              buildSliverListBody()
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigator(context),
    );
  }

  Container buildBottomNavigator(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: 11.h, horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Harga",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 12.sp,
                      color: textDark2,
                    )),
                Text(currencyFormatExtension(course.price),
                    style: ralewayTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: primary1,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.w),
            child: ButtonIconWidget(
              onTap: () {
                context.read<CartCubit>().addCourse(
                      userId: (context.read<UserCubit>().state as UserLoaded)
                          .user
                          .id
                          .toString(),
                      courseId: course.id.toString(),
                      discount: "0",
                    );
              },
              label: Text("Keranjang",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: bgLight2,
                      fontWeight: FontWeight.w600)),
              iconLeft: Icon(
                UniconsLine.plus,
                size: 16.sp,
                color: bgLight2,
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverList buildSliverListBody() {
    return SliverList(
        delegate: SliverChildListDelegate([
      (course.isDiscount)
          ? Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 0),
              child: Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                        color: secondary6,
                        borderRadius: BorderRadius.circular(100.r)),
                    child: Text(
                      "Disc",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 12.sp, color: secondary1),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: " Early Bird ",
                          style: ralewayTextStyle.copyWith(
                            color: textDark3,
                            fontSize: 12.sp,
                          )),
                      TextSpan(
                          text: "${currencyFormatExtension(course.basePrice)}",
                          style: ralewayTextStyle.copyWith(
                              color: textDark3,
                              fontSize: 12.sp,
                              decoration: TextDecoration.lineThrough)),
                    ])),
                  ),
                ],
              ),
            )
          : SizedBox(),
      Padding(
        padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 0),
        child: Row(
          children: [
            Container(
              height: 8.w,
              width: 8.w,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: primary1),
            ),
            SizedBox(width: 8.w),
            Text("Pelatihan ${course.type}",
                style: ralewayTextStyle.copyWith(
                  color: textDark2,
                  fontSize: 12.sp,
                ))
          ],
        ),
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(24.w, 8.w, 24.w, 0),
          child: Text(course.title,
              style: playfairDisplayTextStyle.copyWith(
                  color: textDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp))),
      Divider(
        height: 24.h,
        color: grey2,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
          child: Row(
            children: [
              Icon(
                UniconsLine.calender,
                size: 12.sp,
                color: primary1,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text("Sabtu - Ahad, 19 - 20 Februari 2020",
                  style: ralewayTextStyle.copyWith(
                      color: textDark2, fontSize: 12.sp)),
            ],
          )),
      Divider(
        height: 24.h,
        color: grey2,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Deskripsi",
                  style: playfairDisplayTextStyle.copyWith(
                      color: primary1,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp)),
              SizedBox(
                height: 8.h,
              ),
              Text(course.description,
                  style: ralewayTextStyle.copyWith(
                      color: textDark2, fontSize: 14.sp)),
            ],
          )),
      Divider(
        height: 24.h,
        color: grey2,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fasilitas",
                  style: playfairDisplayTextStyle.copyWith(
                      color: primary1,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp)),
              SizedBox(
                height: 8.h,
              ),
              ...List.generate(
                course.listFasilitas.length,
                (index) => Text(" - ${course.listFasilitas[index]}",
                    style: ralewayTextStyle.copyWith(
                        color: textDark2, fontSize: 14.sp)),
              )
            ],
          )),
      Divider(
        height: 24.h,
        color: grey2,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lokasi",
                  style: playfairDisplayTextStyle.copyWith(
                      color: primary1,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp)),
              SizedBox(
                height: 8.h,
              ),
              Text(course.address,
                  style: ralewayTextStyle.copyWith(
                      color: textDark2, fontSize: 14.sp)),
            ],
          )),
    ]));
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final CourseModel course;

  MySliverAppBar({@required this.expandedHeight, this.course});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        FadeInImage(
          height: 370.h,
          width: double.infinity,
          placeholder: AssetImage("assets/images/placeholder.jpg"),
          image: NetworkImage(course.images[0].file),
          fit: BoxFit.cover,
        ),
        Stack(
          children: [
            Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin, vertical: 4.h),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconBtnWithCounter(
                    icon: UniconsLine.angle_left_b,
                    backgroundColor: Colors.white,
                    numOfItems: 0,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      child: Opacity(
                          opacity: shrinkOffset / expandedHeight,
                          child: Text(
                            "${course.title}\n",
                            overflow: TextOverflow.ellipsis,
                            style: playfairDisplayTextStyle.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: textDark1),
                          ))),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconBtnWithCounter(
                      icon: UniconsLine.share_alt,
                      backgroundColor: Colors.white,
                      numOfItems: 0,
                      onTap: () {
                        print("tekan");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  IconBtnWithCounter(
                    icon: UniconsLine.shopping_cart,
                    backgroundColor: Colors.white,
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
                    onTap: () {
                      context.read<CartCubit>().getCart(
                          (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .id
                              .toString());
                      Get.to(CartScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
