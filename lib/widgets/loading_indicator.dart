import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsi_mobile/shared/shared.dart';

SpinKitCircle loadingIndicator({double size, Color color}) {
  return SpinKitCircle(
    color: color ?? primary1,
    size: size ?? 50,
  );
}

Widget customLoadingIndicator = Dialog(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [loadingIndicator()],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 10.w, 10.w, 10.w),
        child: Text(
          "Loading...",
          style:
              ralewayTextStyle.copyWith(fontSize: 25.sp, color: Colors.black),
        ),
      ),
    ],
  ),
);
