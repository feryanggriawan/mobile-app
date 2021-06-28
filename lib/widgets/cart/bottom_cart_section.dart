import 'package:flutter/material.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/pasien/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomCartSection extends StatelessWidget {
  final String total;
  final GestureTapCallback onTap;
  final Icon iconData;
  final String buttonTitle;

  const BottomCartSection({Key key, this.total, this.onTap, this.iconData, this.buttonTitle}) : super(key: key);

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total belanja",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                Wrap(
                  children: [
                    Text(
                      currencyFormatExtension(
                        total.toString(),
                      ),
                      style: ralewayTextStyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: primary1,
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 20.sp,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ButtonPasien(
            onTap: () {
              if (total != "0") onTap();
            },
            icon: iconData,
            boxDecoration: BoxDecoration(
                color: (total == "0") ? secondary6 : secondary1,
                borderRadius: BorderRadius.circular(20.sp)),
            textStyle:
                ralewayTextStyle.copyWith(fontSize: 12.sp, color: Colors.white),
            title: buttonTitle ?? "Keranjang",
          )
        ],
      ),
    );
  }
}
