import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSeperatorCheckout extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final GestureTapCallback onTap;

  const HeaderSeperatorCheckout(
      {Key key, this.title, this.buttonTitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: ralewayTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp
            ),
          ),
        ),
        if (onTap != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              buttonTitle,
              style:
                  ralewayTextStyle.copyWith(color: primary1, fontSize: 12.sp),
            ),
          )
      ],
    );
  }
}
