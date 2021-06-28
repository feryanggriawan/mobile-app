import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonPasien extends StatelessWidget {
  final BoxDecoration boxDecoration;
  final TextStyle textStyle;
  final String title;
  final GestureTapCallback onTap;

  final Widget icon;

  const ButtonPasien(
      {Key key,
      this.boxDecoration,
      this.textStyle,
      this.title,
      this.onTap,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: boxDecoration,
          padding: EdgeInsets.symmetric(
            vertical: 8.sp,
            horizontal: 2.sp,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon,
              if (icon != null) SizedBox(width: 2.sp,),
              Text(
                title,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
