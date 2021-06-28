import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/pasien/detail.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/pasien/button.dart';
import 'package:tsi_mobile/widgets/terapis/terapis.dart';


class TerapisPasienDataWidget extends StatefulWidget {
  final Pasien pasien;
  final bool expanded;
  final int index;

  const TerapisPasienDataWidget({Key key, this.pasien, this.expanded, this.index})
      : super(key: key);

  @override
  _TerapisPasienDataWidgetState createState() =>
      _TerapisPasienDataWidgetState();
}

class _TerapisPasienDataWidgetState extends State<TerapisPasienDataWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(),
      secondChild: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            TextAreaTerapisWidget(
                title: "No. Hp",
                rightWidget: Row(
                  children: [
                    Text(
                      "${widget.pasien?.phone ?? "-"}",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      child: Text(
                        "Copy",
                        style: ralewayTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: primary1,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 15.h,
            ),
            TextAreaTerapisWidget(
              title: "Nama Penyakit",
              rightWidget: Expanded(
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: <InlineSpan>[
                      if (widget.pasien.release != null)
                        for (var e in widget.pasien.release[widget.index].penyakit)
                          TextSpan(
                            text: "$e , ",
                            style: TextStyle(color: Colors.black),
                          ),
                    ],
                    style: ralewayTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextAreaTerapisWidget(
              title: "Keluhan",
              isVertical: true,
              rightWidget: Row(
                children: [
                  if (widget.pasien.release != null)
                    Text(
                      "${widget.pasien?.release[widget.index].keluhan ?? "-"}",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                ButtonPasien(
                  onTap: () => Get.to(PasienDetailScreen(pasien: widget.pasien,)),
                  boxDecoration: BoxDecoration(
                      color: secondary1,
                      borderRadius: BorderRadius.circular(20.sp)),
                  textStyle: ralewayTextStyle.copyWith(
                      fontSize: 12.sp, color: Colors.white),
                  title: "Lihat Detail Diagnosa",
                ),
              ],
            )
          ],
        ),
      ),
      crossFadeState: !widget.expanded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 300),
    );
  }
}
