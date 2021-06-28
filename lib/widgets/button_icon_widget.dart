import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class ButtonIconWidget extends StatelessWidget {
  const ButtonIconWidget({
    Key key,
    this.onTap,
    this.label,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.iconLeft,
    this.iconRight,
    this.height,
  }) : super(key: key);
  final Function onTap;
  final Text label;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle textStyle;
  final Icon iconLeft;
  final Widget iconRight;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height != null) ? height : 44.h,
      child: FlatButton(
          color: backgroundColor ?? secondary2,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
              side: BorderSide(color: borderColor ?? secondary2)),
          onPressed: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (iconLeft != null)
                  ? Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: iconLeft,
                    )
                  : SizedBox(),
              label,
              (iconRight != null)
                  ? Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: iconRight,
                    )
                  : SizedBox()
            ],
          )),
    );
  }
}
