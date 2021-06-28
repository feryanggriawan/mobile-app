import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class TextAreaTerapisWidget extends StatelessWidget {
  final String title;
  final Widget rightWidget;
  final isVertical;

  const TextAreaTerapisWidget(
      {Key key, this.title, this.rightWidget, this.isVertical = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 10.w,
      ),
      child: isVertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 12.sp, color: textDark2),
                ),
                SizedBox(height: 5.h,),
                rightWidget
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Text(
                    "$title",
                    style: ralewayTextStyle.copyWith(
                        fontSize: 12.sp, color: textDark2),
                  ),
                ),
                if (rightWidget != null) rightWidget
              ],
            ),
      decoration: BoxDecoration(
        color: primary5.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5.h),
        border: Border.all(width: 0.5, color: grey),
      ),
    );
  }
}
