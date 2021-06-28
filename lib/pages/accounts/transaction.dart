import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tsi_mobile/pages/accounts/main.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrderHistory extends StatefulWidget {
  @override
  _UserOrderHistoryState createState() => _UserOrderHistoryState();
}

class _UserOrderHistoryState extends State<UserOrderHistory>
    with SingleTickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  TabController tabController;

  double pixels = 0;

  int index = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: AnimatedAppbarWidget(
              firstTitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "History Transaksi",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pixels: pixels,
              secondSuffix: Container(),
              firstSuffix: Container(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "History Transaksi",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              showHideIn: 50.h,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    labelStyle: ralewayTextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primary1,
                    onTap: (v) {
                      setState(() {
                        index = v;
                      });
                    },
                    tabs: [
                      Tab(
                        text: "Order Story",
                      ),
                      Tab(
                        text: "Tracking",
                      ),
                    ],
                    controller: tabController,
                  ),
                  IndexedStack(
                    index: index,
                    children: [
                      OrderHistoryFragment(),
                      TrackingFragment(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
