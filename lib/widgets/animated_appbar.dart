import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:unicons/unicons.dart';
import 'icon_btn_with_counter_widget.dart';

class AnimatedAppbarWidget extends StatelessWidget {
  final double pixels;
  final double showHideIn;
  final Widget title;
  final Widget firstPrefix;
  final Widget firstSuffix;
  final Widget secondPrefix;
  final Widget secondSuffix;
  final Widget firstTitle;

  const AnimatedAppbarWidget(
      {Key key,
      this.pixels,
      this.showHideIn,
      this.title,
      this.firstTitle,
      this.firstPrefix,
      this.firstSuffix,
      this.secondPrefix,
      this.secondSuffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 6.h),
        width: double.infinity,
        child: Row(
          children: [
            firstPrefix ??
                IconBtnWithCounter(
                  icon: UniconsLine.angle_left_b,
                  backgroundColor: Colors.white,
                  numOfItems: 0,
                  onTap: () {
                    Get.back();
                  },
                ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: firstTitle ?? Container(),
            ),
            SizedBox(
              width: 16.w,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: firstSuffix ??
                  IconBtnWithCounter(
                    icon: UniconsLine.share_alt,
                    backgroundColor: Colors.white,
                    numOfItems: 0,
                    onTap: () {
                      print("tekan");
                    },
                  ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: defaultMargin,
            right: defaultMargin,
            bottom: 8.sp),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        width: double.infinity,
        child: Row(
          children: [
            secondPrefix ??
                IconBtnWithCounter(
                  icon: UniconsLine.angle_left_b,
                  backgroundColor: Colors.white,
                  shadow: false,
                  numOfItems: 0,
                  onTap: () {
                    Get.back();
                  },
                ),
            Expanded(
              child: title,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: secondSuffix ??
                  IconBtnWithCounter(
                    icon: UniconsLine.share_alt,
                    backgroundColor: Colors.white,
                    numOfItems: 0,
                    shadow: false,
                    onTap: () {
                      print("tekan");
                    },
                  ),
            ),
          ],
        ),
      ),
      crossFadeState: pixels <= showHideIn ?? 50.h
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
    );
  }
}
