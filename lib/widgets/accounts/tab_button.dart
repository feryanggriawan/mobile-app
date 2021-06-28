import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTabButton extends StatelessWidget {
  final ValueChanged<int> onChange;
  final int currenState;
  final int thisState;
  final String title;

  const AccountTabButton(
      {Key key,
      @required this.onChange,
      @required this.title,
      @required this.currenState,
      @required this.thisState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(thisState);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
        margin: EdgeInsets.only(right: 5.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(width: 1, color: primary1),
            color: currenState == thisState ? primary1 : Colors.white),
        child: Text(
          title,
          style: ralewayTextStyle.copyWith(
            color: currenState == thisState ? Colors.white : primary1,
          ),
        ),
      ),
    );
  }
}
