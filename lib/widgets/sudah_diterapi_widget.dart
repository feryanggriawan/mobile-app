import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:unicons/unicons.dart';
import 'button_icon_widget.dart';

class SudahDiterapiWidget extends StatelessWidget {
  const SudahDiterapiWidget({
    Key key,
    @required this.image,
    @required this.onTap,
    this.paddingLeft,
    this.paddingRight,
    this.name,
    this.date,
    this.gender,
    this.hour,
    this.age,
    this.disease,
  }) : super(key: key);

  final String name, image, date, gender, hour;
  final GestureTapCallback onTap;
  final int age;
  final List<String> disease;
  final double paddingLeft, paddingRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          width: 220.w,
          height: 180.h,
          padding: EdgeInsets.all(
            16.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.03),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "$date - ",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 8.sp,
                      color: textDark2,
                      fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: "$hour",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 8.sp,
                      color: textDark2,
                      fontWeight: FontWeight.w400),
                ),
              ])),
              SizedBox(height: 15.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundImage: NetworkImage(
                      "$image",
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "$name",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 14.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: "\n$gender, ",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 8.sp,
                          color: textDark3,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: "$age Tahun",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 8.sp,
                          color: textDark3,
                          fontWeight: FontWeight.w400),
                    ),
                  ])),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "Gejala:",
                style: ralewayTextStyle.copyWith(
                    fontSize: 8.sp,
                    color: textDark3,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 4.h),
              Wrap(
                children: disease.map((e) {
                  if (e == disease.first) {
                    return Text(
                      "$e",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 8.sp,
                          color: primary1,
                          fontWeight: FontWeight.w600),
                    );
                  } else {
                    return Text(
                      ", $e",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 8.sp,
                          color: primary1,
                          fontWeight: FontWeight.w600),
                    );
                  }
                }).toList(),
              ),
              SizedBox(height: 15.h),
              ButtonIconWidget(
                height: 28.h,
                label: Text(" Follow Up",
                    style: ralewayTextStyle.copyWith(
                        color: bgLight2, fontSize: 8.sp)),
                iconLeft: Icon(
                  UniconsLine.whatsapp,
                  size: 10.sp,
                  color: textLight2,
                ),
                onTap: () {
                  if (onTap != null) {
                    onTap();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
