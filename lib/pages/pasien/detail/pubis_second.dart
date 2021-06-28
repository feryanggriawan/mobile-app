import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/terapis/terapis.dart';

class PubisSecondFragment extends StatelessWidget {
  final Release release;

  const PubisSecondFragment({Key key, this.release}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pubis 2",
            style: ralewayTextStyle.copyWith(
              fontSize: 20.sp,
              color: textDark1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 18.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: release.pubis.data2.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAreaTerapisWidget(
                    title: e.sebelah,
                    rightWidget: Row(
                      children: [
                        Text(
                          "${e.bagian} (${e.value})",
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
                    height: 8.sp,
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
