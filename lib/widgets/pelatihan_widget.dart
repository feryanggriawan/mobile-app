import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/course_offline_cubit/course_offline_cubit.dart';
import 'package:tsi_mobile/cubit/course_online_cubit/course_online_cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/course_pages/detail_course_page.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'loading_indicator.dart';

class PelatihanWidget extends StatefulWidget {
  const PelatihanWidget({
    Key key,
  }) : super(key: key);

  @override
  _PelatihanWidgetState createState() => _PelatihanWidgetState();
}

class _PelatihanWidgetState extends State<PelatihanWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPelatihanOnline(),
        buildPelatihanOffline(),
      ],
    );
  }

  Column buildPelatihanOnline() {
    int courseLength = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel("Online", courseLength),
        BlocBuilder<CourseOnlineCubit, CourseOnlineState>(
          builder: (_, state) {
            if (state is CourseOnlineLoaded) {
              if (state.coursesOnline != null) {
                courseLength = state.coursesOnline.length;
                return SizedBox(
                    height: 125.h,
                    child: ListView.builder(
                        itemCount: state.coursesOnline.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return buildPelatihanCard(index, state.coursesOnline);
                        }));
              } else {
                return SizedBox();
              }
            } else if (state is CourseOnlineLoadingFailed) {
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

  Column buildPelatihanOffline() {
    int courseLength = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel("Offline", courseLength),
        BlocBuilder<CourseOfflineCubit, CourseOfflineState>(
          builder: (_, state) {
            if (state is CourseOfflineLoaded) {
              if (state.coursesOffline != null) {
                courseLength = state.coursesOffline.length;
                return SizedBox(
                    height: 125.h,
                    child: ListView.builder(
                        itemCount: state.coursesOffline.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return buildPelatihanCard(
                              index, state.coursesOffline);
                        }));
              } else {
                return SizedBox();
              }
            } else if (state is CourseOfflineLoadingFailed) {
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

  GestureDetector buildPelatihanCard(
      int index, List<CourseModel> listPelatihan) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailCoursePage(listPelatihan[index]));
      },
      child: Container(
          height: 125.h,
          width: 272.w,
          margin: EdgeInsets.only(
              left: defaultMargin,
              right: (index == listPelatihan.length - 1) ? defaultMargin : 0),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.03),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              buildCourseImage(listPelatihan[index].images[0].file),
              SizedBox(width: 15.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listPelatihan[index].title,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: textDark1,
                              fontWeight: FontWeight.w700)),
                      (listPelatihan[index].isDiscount)
                          ? buildIsDiscount(listPelatihan, index)
                          : SizedBox(),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                          "${currencyFormatExtension(listPelatihan[index].price)}",
                          style: ralewayTextStyle.copyWith(
                              color: primary1,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  ClipRRect buildCourseImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: FadeInImage(
        height: 104.w,
        width: 104.w,
        placeholder: AssetImage("assets/images/placeholder.jpg"),
        image: NetworkImage(
          imageUrl,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Padding buildIsDiscount(List<CourseModel> listPelatihan, int index) {
    return Padding(
      padding: EdgeInsets.only(top: 7.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    color: secondary6,
                    borderRadius: BorderRadius.circular(100.r)),
                child: Text(
                  "Disc",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 8.sp, color: secondary1),
                ),
              ),
              Expanded(
                child: Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: " Early Bird",
                      style: ralewayTextStyle.copyWith(
                        color: textDark3,
                        fontSize: 8.sp,
                      )),
                  TextSpan(
                      text:
                          " ${currencyFormatExtension(listPelatihan[index].price)}",
                      style: ralewayTextStyle.copyWith(
                          color: textDark3,
                          fontSize: 8.sp,
                          decoration: TextDecoration.lineThrough)),
                ])),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          buildSisaWaktuDiscount()
        ],
      ),
    );
  }

  Text buildSisaWaktuDiscount() {
    return Text("SISA WAKTU 0 HARI LAGI",
        style: ralewayTextStyle.copyWith(
            color: error, fontSize: 6.sp, fontWeight: FontWeight.w700));
  }

  Padding buildLabel(String label, int listPelatihanLength) {
    return Padding(
      padding: EdgeInsets.only(left: defaultMargin, bottom: 8.h, top: 16.h),
      child: Text("$label ($listPelatihanLength)",
          style: ralewayTextStyle.copyWith(fontSize: 14.sp, color: primary1)),
    );
  }
}
