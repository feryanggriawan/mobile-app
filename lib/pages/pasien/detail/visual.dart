import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/terapis/terapis.dart';

class VisualFragment extends StatelessWidget {
  final Release release;

  const VisualFragment({Key key, this.release}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visual",
            style: ralewayTextStyle.copyWith(
              fontSize: 20.sp,
              color: textDark1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 18.sp,
          ),
          TextAreaTerapisWidget(
            title: "Varian Kaki",
            rightWidget: Row(
              children: [
                Text(
                  "${release?.visual?.kaki?.variant ?? "-"}",
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
          TextAreaTerapisWidget(
            title: "Kaki Kanan",
            rightWidget: Row(
              children: [
                Text(
                  "${release?.visual?.kaki?.kanan ?? "-"}",
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
          TextAreaTerapisWidget(
            title: "Kaki Kiri",
            rightWidget: Row(
              children: [
                Text(
                  "${release?.visual?.kaki?.kiri ?? "-"}",
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
            height: 20.sp,
          ),
          TextAreaTerapisWidget(
            title: "Varian Pundak",
            rightWidget: Row(
              children: [
                Text(
                  "${release?.visual?.pundak?.variant ?? "-"}",
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
          TextAreaTerapisWidget(
            title: "Pundak Kanan",
            rightWidget: Row(
              children: [
                Text(
                  "${release?.visual?.pundak?.kanan ?? "-"}",
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
          TextAreaTerapisWidget(
            title: "Pundak Kiri",
            rightWidget: Row(
              children: [
                Text(
                  "${release?.visual?.pundak?.kiri ?? "-"}",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
