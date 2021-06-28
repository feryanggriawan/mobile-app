import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectAllSectionWidget extends StatelessWidget {
  final bool checkBoxValue;
  final String title;
  final ValueChanged<bool> onChanged;

  const SelectAllSectionWidget({Key key, this.checkBoxValue, this.title, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Checkbox(
            value: checkBoxValue,
            onChanged: onChanged,
            activeColor: primary1,
          ),
          width: 20.sp,
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: Text(
            title,
            style: playfairDisplayTextStyle.copyWith(
              color: primary1,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
