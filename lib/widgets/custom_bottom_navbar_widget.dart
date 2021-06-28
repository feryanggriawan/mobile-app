import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class CustomTabBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;

  CustomTabBarWidget({@required this.titles, this.selectedIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 48),
            height: 1,
            color: Colors.red,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: titles
                  .map((e) => Padding(
                        padding: EdgeInsets.only(
                            left: (e == titles.first) ? defaultMargin : 8.w,
                            right: (e == titles.last) ? defaultMargin : 0),
                        child: GestureDetector(
                          onTap: () {
                            if (onTap != null) {
                              onTap(titles.indexOf(e));
                            }
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            decoration: BoxDecoration(
                                color: (titles.indexOf(e) == selectedIndex)
                                    ? primary1
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(color: primary1)),
                            child: Center(
                              child: Text(
                                e,
                                style: (titles.indexOf(e) == selectedIndex)
                                    ? ralewayTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: textLight2)
                                    : ralewayTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: primary1),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
