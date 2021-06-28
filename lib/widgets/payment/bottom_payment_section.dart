import 'package:flutter/material.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomPaymentSection extends StatelessWidget {
  final String total;
  final String anotherCharge;
  final GestureTapCallback onTap;
  final Icon iconData;
  final String buttonTitle;
  final bool canNext;

  const BottomPaymentSection(
      {Key key,
      this.total,
      this.onTap,
      this.iconData,
      this.buttonTitle,
      this.anotherCharge,
      this.canNext})
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
          Text(
            "Ringkasan Pembayaran",
            style: ralewayTextStyle.copyWith(
              fontSize: 14.sp,
              color: primary1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Total Tagihan",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: grey,
                  ),
                ),
              ),
              Text(
                currencyFormatExtension(
                  total.toString(),
                ),
                style: ralewayTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: textDark1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Biaya Lainnya",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: grey),
                ),
              ),
              Text(
                currencyFormatExtension(
                  anotherCharge.toString(),
                ),
                style: ralewayTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: textDark1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.w,
          ),
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
                    "Lanjutkan Pembayaran",
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
