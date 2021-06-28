import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/pages/pasien/detail.dart';
import 'package:tsi_mobile/shared/shared.dart';

class MemberTerapiItem extends StatefulWidget {
  final Pasien pasien;

  const MemberTerapiItem({Key key, this.pasien}) : super(key: key);

  @override
  _MemberTerapiItemState createState() => _MemberTerapiItemState();
}

class _MemberTerapiItemState extends State<MemberTerapiItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.only(bottom: 16.h, right: 15.sp, left: 15.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.03),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                child: Image.network(
                  widget.pasien.photo,
                  width: 58.w,
                  height: 58.w,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "${widget.pasien?.name ?? ""}",
                                  style: playfairDisplayTextStyle.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: textDark1),
                                ),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              SvgPicture.asset(
                                "assets/icons/verifikasi.svg",
                                height: 12.w,
                                width: 12.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              Text(
                                  "${widget.pasien.jenisKelamin ?? "Tidak Disebutkan"}",
                                  style: ralewayTextStyle.copyWith(
                                      fontSize: 8.sp, color: textDark2)),
                              SizedBox(
                                width: 4.h,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  height: 4.w,
                                  width: 4.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      color: textDark2)),
                              SizedBox(
                                width: 4.h,
                              ),
                              Text(
                                "${widget.pasien.usia} Tahun",
                                style: ralewayTextStyle.copyWith(
                                    fontSize: 8.sp, color: textDark2),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text("${widget.pasien.location}",
                              style: ralewayTextStyle.copyWith(
                                  fontSize: 8.sp, color: textDark2)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(PasienDetailScreen(pasien: widget.pasien,)),
                      child: Row(children: [
                        Text("Lihat Detail",
                            style: ralewayTextStyle.copyWith(
                                fontSize: 12.sp, color: primary1)),
                        Icon(Icons.arrow_forward, color: primary1, size: 12.sp,)
                      ],),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
