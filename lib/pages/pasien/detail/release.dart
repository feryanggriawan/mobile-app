import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class ReleaseFragment extends StatelessWidget {
  final Release release;

  const ReleaseFragment({Key key, this.release}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tingkat Release",
            style: ralewayTextStyle.copyWith(
              fontSize: 20.sp,
              color: textDark1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 18.sp,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: grey),
              borderRadius: BorderRadius.circular(10.sp)
            ),
            padding: EdgeInsets.only(top: 60.sp, left: 10.sp, right: 10.sp, bottom: 20.sp),
            child: SfSliderTheme(
              data: SfSliderThemeData(
                tooltipBackgroundColor: primary1,
                tooltipTextStyle: TextStyle(fontSize: 20.sp,),
              ),
              child: SfSlider(
                min: 0.0,
                max: 100.0,
                value: double.parse(release.value),
                interval: 10.0,
                showTicks: true,
                inactiveColor: primary4,
                activeColor: primary1,
                showLabels: true,
                enableTooltip: true,
                tooltipShape: SfPaddleTooltipShape(),
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  // setState(() {
                  //   _value = value;
                  // });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
