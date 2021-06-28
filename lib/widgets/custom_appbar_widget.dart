import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:unicons/unicons.dart';
import 'icon_btn_with_counter_widget.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    Key key,
    this.widgetLeft,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final Widget widgetLeft;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(defaultMargin, 13.h, defaultMargin, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widgetLeft,
          IconBtnWithCounter(
            shadow: false,
            icon: icon ?? UniconsLine.bell,
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
          )
        ],
      ),
    );
  }
}
