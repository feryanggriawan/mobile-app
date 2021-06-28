import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/detail_order.dart';
import 'package:tsi_mobile/models/order_history.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/accounts/main.dart';

class ExpandedOrderCard extends StatefulWidget {
  final OrderHistory orderHistory;
  final bool showButton;
  const ExpandedOrderCard({Key key, this.orderHistory, this.showButton = true}) : super(key: key);

  @override
  _ExpandedOrderCardState createState() => _ExpandedOrderCardState();
}

class _ExpandedOrderCardState extends State<ExpandedOrderCard> {
  final orderDetail = OrderDetailCubit();
  List<CourseDetail> courses = [];
  List<Product> product = [];

  bool expanded = false;

  @override
  void initState() {
    orderDetail.getOrderDetail(widget.orderHistory.orderId.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is OrderDetailInitial) {
          courses.clear();
          product.clear();
          setState(() {});
        }

        if (state is OrderDetailLoaded) {
          print(state.order.data.toJson());
          courses.addAll(state.order.data.course);
          product.addAll(state.order.data.product);

          setState(() {});
        }
      },
      cubit: orderDetail,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.orderHistory.invoice,
                        style: ralewayTextStyle.copyWith(
                          color: primary1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        toDateString(
                            DateTime.parse(widget.orderHistory.created)),
                        style: ralewayTextStyle.copyWith(
                          color: grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: grey,
                )
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            OrderHistoryData(
              expanded: expanded,
              course: courses,
              product: product,
              orderHistory: widget.orderHistory,
              showButton : widget.showButton
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
