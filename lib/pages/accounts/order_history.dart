import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/order_history/order_history_cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/accounts/expanded_order_card.dart';
import 'package:tsi_mobile/widgets/accounts/main.dart';
import 'package:tsi_mobile/widgets/no_data.dart';

class OrderHistoryFragment extends StatefulWidget {
  @override
  _OrderHistoryFragmentState createState() => _OrderHistoryFragmentState();
}

class _OrderHistoryFragmentState extends State<OrderHistoryFragment> {
  int index = 0;

  OrderHistoryCubit orderHistoryCubit = OrderHistoryCubit();

  @override
  void initState() {
    getOrderHistoryData("pending");
    super.initState();
  }

  void getOrderHistoryData(String status) async {
    final body = {
      "user":
          (context.read<UserCubit>().state as UserLoaded).user.id.toString(),
      "status": status,
    };

    orderHistoryCubit = new OrderHistoryCubit();

    orderHistoryCubit.getOrderHistory(body: body);
  }

  String generateStatus(String status) {
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AccountTabButton(
                onChange: (v) {
                  setState(() {
                    index = v;
                  });

                  getOrderHistoryData(generateStatus("pending"));
                },
                currenState: index,
                thisState: 0,
                title: "Pending",
              ),
              AccountTabButton(
                onChange: (v) {
                  setState(() {
                    index = v;
                  });

                  getOrderHistoryData("payment-confirmation");
                },
                currenState: index,
                thisState: 1,
                title: "Konfirmasi",
              ),
              AccountTabButton(
                onChange: (v) {
                  setState(() {
                    index = v;
                  });

                  getOrderHistoryData(generateStatus("payment-accepted"));
                },
                currenState: index,
                thisState: 2,
                title: "Lunas",
              ),
            ],
          ),
          SizedBox(
            height: 15.sp,
          ),
          BlocBuilder(
            cubit: orderHistoryCubit,
            builder: (context, state) {
              if (state is OrderHistoryInitial) {
                return SpinKitCircle(
                  color: primary1,
                );
              }
              if (state is OrderHistoryLoaded) {
                if (state.terapies == null) {
                  return NoDataWidget(
                    message: "Tidak Ada Order",
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) => ExpandedOrderCard(
                    orderHistory: state.terapies[index],
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.terapies.length,
                );
              }

              if (state is OrderHistoryLoadingFailed) {
                return Center(
                  child: NoDataWidget(
                    message: "Tidak Ada Order",
                  ),
                );
              }

              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
