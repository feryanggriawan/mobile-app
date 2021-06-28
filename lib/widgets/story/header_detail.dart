

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicons/unicons.dart';

class StoryHeaderDetailWidget extends StatelessWidget {
  final String title;
  final String name;
  final String date;
  final String location;
  final List<String> category;

  const StoryHeaderDetailWidget({
    Key key,
    @required this.title,
    @required this.name,
    @required this.date,
    this.location,
    this.category = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: playfairDisplayTextStyle.copyWith(
            fontSize: 24.sp,
            color: textDark1,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 17.sp,
        ),
        Row(
          children: [
            Icon(
              UniconsLine.user,
              size: 14.sp,
              color: textDark2,
            ),
            SizedBox(
              width: 8.sp,
            ),
            Text("$name",
                style: ralewayTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: textDark2)),
            SizedBox(
              width: 8.sp,
            ),
            SvgPicture.asset(
              "assets/icons/verifikasi.svg",
              height: 12.sp,
              width: 12.sp,
            ),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          children: [
            Icon(
              UniconsLine.calender,
              size: 14.sp,
              color: textDark2,
            ),
            SizedBox(
              width: 8.sp,
            ),
            Text(
              "$date",
              style: ralewayTextStyle.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: textDark2,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        if (location != null)
          Row(
            children: [
              Icon(
                UniconsLine.location_pin_alt,
                size: 14.sp,
                color: textDark2,
              ),
              SizedBox(
                width: 8.sp,
              ),
              Text(
                location,
                style: ralewayTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: textDark2,
                ),
              )
            ],
          ),
        if (category.isNotEmpty)
          SizedBox(
            height: 17.sp,
          ),
        if (category.isNotEmpty)
          Row(
            children: category
                .map(
                  (e) => Container(
                    margin: EdgeInsets.only(right: 5.sp),
                    padding:
                        EdgeInsets.symmetric(vertical: 4.sp, horizontal: 12.sp),
                    decoration: BoxDecoration(
                      color: textDark2,
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Text(
                      e,
                      style: ralewayTextStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
