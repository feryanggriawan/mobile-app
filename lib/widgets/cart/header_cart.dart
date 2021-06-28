import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCart extends StatelessWidget {
  final double pixels;

  const HeaderCart({Key key, this.pixels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedAppbarWidget(
        firstTitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Keranjang",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: playfairDisplayTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        pixels: pixels,
        secondSuffix: Container(),
        firstSuffix: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Keranjang",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: playfairDisplayTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        showHideIn: 50.h,
      ),
    );
  }
}
