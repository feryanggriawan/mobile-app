import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    this.onTap,
    this.label,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
  }) : super(key: key);
  final Function onTap;
  final String label;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: FlatButton(
          color: backgroundColor ?? secondary2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
              side: BorderSide(color: borderColor ?? secondary2)),
          onPressed: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Text(
            label ?? "",
            style: textStyle.copyWith(color: textColor ?? Colors.white),
          )),
    );
  }
}
