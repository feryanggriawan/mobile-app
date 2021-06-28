import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/pasien/pasien_data.dart';

class PasienItemExpanded extends StatefulWidget {
  final Pasien pasien;

  const PasienItemExpanded({Key key, this.pasien}) : super(key: key);

  @override
  _PasienItemExpandedState createState() => _PasienItemExpandedState();
}

class _PasienItemExpandedState extends State<PasienItemExpanded> {
  bool expanded = false;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          if (widget.pasien.release != null)
                            Text(
                              "Diterapi ${widget.pasien.release.length > 0 ? DateFormat("dd MMMM yyyy").format(
                                  DateTime.parse(
                                    widget.pasien.release.last.schedule,
                                  ),
                                ) : "Tidak Disebutkan"}",
                              style: ralewayTextStyle.copyWith(
                                  fontSize: 12.sp, color: textDark2),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentIndex > 0) {
                              setState(() {
                                currentIndex = currentIndex - 1;
                              });
                            }
                          },
                          child: Icon(Icons.keyboard_arrow_left),
                        ),
                        Text(
                            "${currentIndex + 1} / ${widget.pasien.release.length}"),
                        GestureDetector(
                          onTap: () {
                            if (currentIndex <
                                (widget.pasien.release.length - 1)) {
                              setState(() {
                                currentIndex = currentIndex + 1;
                              });
                            }
                          },
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: renderArrow(),
          ),
          // TerapisDataWidget(pasien: widget.pasien, expanded: expanded,),
          PasienDataWidget(
            pasien: widget.pasien,
            expanded: expanded,
            index: currentIndex,
          )
        ],
      ),
    );
  }

  Widget renderArrow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
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
