import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';

class StorePelatihanPage extends StatefulWidget {
  @override
  _StorePelatihanPageState createState() => _StorePelatihanPageState();
}

class _StorePelatihanPageState extends State<StorePelatihanPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          buildPelatihan(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Column buildPelatihan() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: CustomTabBarWidget(
            titles: ["All", "Terdekat"],
            selectedIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
        (selectedIndex == 0) ? PelatihanWidget() : PelatihanWidget(),
      ],
    );
  }
}
