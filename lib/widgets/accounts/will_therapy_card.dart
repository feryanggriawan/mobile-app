import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/pasien/button.dart';

class MemberWillTerapiItem extends StatefulWidget {
  final Pasien pasien;

  const MemberWillTerapiItem({Key key, this.pasien}) : super(key: key);

  @override
  _MemberWillTerapiItemState createState() => _MemberWillTerapiItemState();
}

class _MemberWillTerapiItemState extends State<MemberWillTerapiItem> {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              widget.pasien.photo,
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(50.w),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.pasien?.name ?? ""}",
                                  style: playfairDisplayTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: textDark1),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${widget.pasien?.jenisKelamin ?? "Tidak Disebutkan"} , ",
                                        style: ralewayTextStyle.copyWith(
                                            fontSize: 10.sp, color: textDark1)),
                                    Text(
                                      "${widget.pasien?.usia ?? "0"} Tahun",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 10.sp, color: textDark1),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal Terapi",
                                  style: playfairDisplayTextStyle.copyWith(
                                      fontSize: 10.sp, color: textDark3),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                    "${widget.pasien?.release?.last?.schedule ?? "Tidak Ada Tanggal"} , ",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 10.sp, color: secondary1)),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text("Gejala",
                          style: ralewayTextStyle.copyWith(
                              fontSize: 10.sp, color: textDark3)),
                      SizedBox(
                        height: 5.sp,
                      ),
                      if (widget.pasien.release != null)
                        Wrap(
                          children: widget.pasien.release.last.penyakit
                              .map<Widget>((e) => Text(
                                    "${e ?? ""} ",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 10.sp, color: primary1),
                                  ))
                              .toList(),
                        ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text("Keluhan",
                          style: ralewayTextStyle.copyWith(
                              fontSize: 10.sp, color: textDark3)),
                      SizedBox(
                        height: 5.sp,
                      ),
                      if (widget.pasien.release != null)
                        Text(
                          "${widget.pasien?.release?.last?.keluhan ?? ""} ",
                          style: ralewayTextStyle.copyWith(
                              fontSize: 10.sp, color: primary2),
                        ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Row(
                        children: [
                          ButtonPasien(
                            onTap: () {},
                            icon: Icon(FontAwesome.whatsapp, color: secondary1, size: 14.sp,),
                            boxDecoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: secondary1,
                                ),
                                borderRadius: BorderRadius.circular(20.sp)),
                            textStyle: ralewayTextStyle.copyWith(
                                fontSize: 12.sp, color: secondary1),
                            title: "Follow Up",
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          ButtonPasien(
                            onTap: () {},
                            icon: Icon(Icons.wheelchair_pickup_outlined, color: Colors.white, size: 14.sp,),
                            boxDecoration: BoxDecoration(
                                color: secondary1,
                                borderRadius: BorderRadius.circular(20.sp)),
                            textStyle: ralewayTextStyle.copyWith(
                                fontSize: 12.sp, color: Colors.white),
                            title: "Terapi Sekarang",
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
