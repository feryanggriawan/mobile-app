import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.icon,
    this.numOfItems,
    this.iconColors,
    this.onTap,
    this.shadow = true,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  final IconData icon;
  final int numOfItems;
  final Color iconColors;
  final Function onTap;
  final Color backgroundColor;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: shadow ? Colors.black12.withOpacity(0.1) : Colors.transparent,
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: iconColors ?? textDark2,
            ),
          ),
          if (numOfItems != 0)
            Positioned(
              right: 9,
              top: 7,
              child: Container(
                height: 14.w,
                width: 14.w,
                decoration: BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white)),
              ),
            )
        ],
      ),
    );
  }
}
