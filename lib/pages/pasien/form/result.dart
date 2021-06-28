import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPasienFragment extends StatefulWidget {
  final ScrollController controller;
  final GestureTapCallback next;
  final ValueChanged onRelease;
  final Map<String, dynamic> release;

  const ResultPasienFragment(
      {Key key, this.controller, this.next, this.onRelease, this.release})
      : super(key: key);

  @override
  _ResultPasienFragmentState createState() => _ResultPasienFragmentState();
}

class _ResultPasienFragmentState extends State<ResultPasienFragment> {
  final result = TextEditingController();
  double valueRelease = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hasil",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            controller: result,
            maxLines: null,
            minLines: 2,
            decoration: InputDecoration(
              hintText: 'Hasil',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.w),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "Tingkat Release",
            style: ralewayTextStyle.copyWith(
                color: textDark2, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: grey),
                borderRadius: BorderRadius.circular(10.sp)),
            padding: EdgeInsets.only(
                top: 60.sp, left: 10.sp, right: 10.sp, bottom: 20.sp),
            child: SfSliderTheme(
              data: SfSliderThemeData(
                tooltipBackgroundColor: primary1,
                tooltipTextStyle: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              child: SfSlider(
                min: 0.0,
                max: 100.0,
                value: valueRelease,
                interval: 10.0,
                showTicks: true,
                inactiveColor: primary4,
                activeColor: primary1,
                showLabels: true,
                enableTooltip: true,
                tooltipShape: SfPaddleTooltipShape(),
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    valueRelease = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          ButtonWidget(
            label: "Lanjutkan",
            textStyle: buttonTextNoneStyle,
            onTap: () async {
              widget.onRelease(
                  {"value": valueRelease, "description": result.text});
              widget.next();
            },
          ),
        ],
      ),
    );
  }
}
