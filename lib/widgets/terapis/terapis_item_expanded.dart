import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/terapis/terapis_data.dart';

class TerapiItemExpanded extends StatefulWidget {
  final Terapis terapis;

  const TerapiItemExpanded({Key key, this.terapis}) : super(key: key);

  @override
  _TerapiItemExpandedState createState() => _TerapiItemExpandedState();
}

class _TerapiItemExpandedState extends State<TerapiItemExpanded> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.only(bottom: 16.h),
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
                  widget.terapis.member.photo,
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
                                  "${widget.terapis?.member?.name ?? ""}",
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
                                  "${widget.terapis.member?.jenisKelamin ?? "Tidak Disebutkan"}",
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
                                "${personAge(
                                  widget.terapis.member?.tanggalLahir != null
                                      ? DateTime.parse(
                                          widget.terapis.member?.tanggalLahir,
                                        )
                                      : null,
                                )} Tahun",
                                style: ralewayTextStyle.copyWith(
                                    fontSize: 8.sp, color: textDark2),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text("${widget.terapis.location}",
                              style: ralewayTextStyle.copyWith(
                                  fontSize: 8.sp, color: textDark2)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      child: renderArrow(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TerapisDataWidget(terapis: widget.terapis, expanded: expanded,),
        ],
      ),
    );
  }

  Widget renderArrow() {
    return Row(
      children: [
        !expanded
            ? Text(
                "Lihat Detail",
                style: ralewayTextStyle.copyWith(
                  fontSize: 10.sp,
                  color: primary1,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                "Sembunyikan",
                style: ralewayTextStyle.copyWith(
                  fontSize: 10.sp,
                  color: primary1,
                  fontWeight: FontWeight.bold,
                ),
              ),
        !expanded
            ? Icon(
                Icons.arrow_drop_down,
                size: 14.sp,
                color: primary1,
              )
            : Icon(
                Icons.arrow_drop_up,
                size: 14.sp,
                color: primary1,
              ),
      ],
    );
  }
}
