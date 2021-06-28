import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/terapis/terapis.dart';

class PubisFirstFragment extends StatelessWidget {
  final Release release;

  const PubisFirstFragment({Key key, this.release}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pubis 1",
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
            title: "Kanan",
            rightWidget: Row(
              children: [
                Text(
                  "Atas (${release?.pubis?.data1?.kanan?.atas ?? "-"}), Bawah (${release?.pubis?.data1?.kanan?.bawah ?? "-"}), Depan (${release?.pubis?.data1?.kanan?.depan ?? "-"}), Samping (${release?.pubis?.data1?.kanan?.samping ?? "-"})",
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
            title: "Kiri",
            rightWidget: Row(
              children: [
                Text(
                  "Atas (${release?.pubis?.data1?.kiri?.atas ?? "-"}), Bawah (${release?.pubis?.data1?.kiri?.bawah ?? "-"}), Depan (${release?.pubis?.data1?.kiri?.depan ?? "-"}), Samping (${release?.pubis?.data1?.kiri?.samping ?? "-"})",
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
