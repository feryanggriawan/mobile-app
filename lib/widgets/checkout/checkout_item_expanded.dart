import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/widgets/checkout/checkout_data.dart';

class CheckoutItemExpanded extends StatefulWidget {
  final OrderDetail order;

  const CheckoutItemExpanded({Key key, this.order}) : super(key: key);

  @override
  _CheckoutItemExpandedState createState() => _CheckoutItemExpandedState();
}

class _CheckoutItemExpandedState extends State<CheckoutItemExpanded> {
  final orderDetailCubit = OrderDetailCubit();

  @override
  void initState() {
    print("idnya ${widget.order.orderId}");

    orderDetailCubit.getOrderDetail(widget.order.orderId.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is OrderDetailLoaded) {
          return CheckoutData(
            order: state.order,
          );
        }

        return SizedBox();
      },
      cubit: orderDetailCubit,
    );
  }
}
