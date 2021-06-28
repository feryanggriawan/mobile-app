import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataWidget extends StatelessWidget {
  final message;

  const NoDataWidget({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/empty-state.png", height: 180.sp),
        Text(
          message ?? "Data Tidak Ditemukan.",
          textAlign: TextAlign.center,
          style: playfairDisplayTextStyle.copyWith(
              fontSize: 20.sp, color: primary1, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
