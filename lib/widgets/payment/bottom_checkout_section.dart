import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomCheckoutSection extends StatelessWidget {
  final String buttonTitle;
  final bool canNext;
  final GestureTapCallback onTap;

  const BottomCheckoutSection(
      {Key key,
      this.buttonTitle,
      this.canNext, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: grey, blurRadius: 2.sp)],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.sp),
            topLeft: Radius.circular(25.sp),
          ),
          color: Colors.white),
      padding: EdgeInsets.only(
        top: 20.sp,
        bottom: MediaQuery.of(context).padding.bottom + 20.sp,
        left: 20.sp,
        right: 10.sp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (canNext) onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: !canNext ? secondary6 : secondary1,
                  borderRadius: BorderRadius.circular(20.sp)),
              padding: EdgeInsets.symmetric(
                vertical: 10.sp,
                horizontal: 2.sp,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonTitle,
                    style: ralewayTextStyle.copyWith(
                        fontSize: 12.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
