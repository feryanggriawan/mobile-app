import 'package:flutter/material.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutData extends StatefulWidget {
  final OrderDetail order;

  const CheckoutData({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  _CheckoutDataState createState() => _CheckoutDataState();
}

class _CheckoutDataState extends State<CheckoutData> {
  bool expanded = false;

  @override
  void didUpdateWidget(covariant CheckoutData oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Tagihan",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 14.sp,
                    color: textDark2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  currencyFormatExtension((int.parse(widget.order.total) +
                          int.parse(widget.order.uniq))
                      .toString()),
                  style: ralewayTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: secondary1,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  "Disertai Dengan Kode Unik",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 10.sp,
                    color: textDark3,
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 5.w,
            ),
            renderArrow(),
          ],
        ),
      ),
      secondChild: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Spacer(),
                renderArrow(),
              ],
            ),
            Divider(),
            SizedBox(
              height: 8.sp,
            ),
            Text(
              "Barang Yang Dibeli",
              style: ralewayTextStyle.copyWith(
                fontSize: 16.sp,
                color: primary1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            if (widget.order.data.product.isNotEmpty)
              Text(
                "Produk",
                style: ralewayTextStyle.copyWith(
                  fontSize: 14.sp,
                  color: secondary1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(
              height: 10.sp,
            ),
            if (widget.order.data.product.isNotEmpty)
              Column(
                children: widget.order.data.product
                    .map(
                      (e) => Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: textDark2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Text(
                                    "${e.qty} x ${currencyFormatExtension(e.total)}",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: textDark3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "${currencyFormatExtension(e.total)}",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: textDark2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 8.sp),
                      ),
                    )
                    .toList(),
              ),
            if (widget.order.data.course.isNotEmpty)
              Text(
                "Produk",
                style: ralewayTextStyle.copyWith(
                  fontSize: 14.sp,
                  color: secondary1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (widget.order.data.course.isNotEmpty)
              Column(
                children: widget.order.data.course
                    .map(
                      (e) => Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: textDark2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Text(
                                    "${e.qty} x ${currencyFormatExtension(e.total)}",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: textDark3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "${currencyFormatExtension(e.total)}",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 14.sp,
                                color: textDark2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 8.sp),
                      ),
                    )
                    .toList(),
              ),
            Divider(
              height: 30.w,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total Harga (${widget.order.data.course.length + widget.order.data.product.length} Barang)",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: textDark2,
                      ),
                    ),
                  ),
                  Text(
                    "${currencyFormatExtension(widget.order.total)}",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: textDark2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(bottom: 8.sp),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Ongkir",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: textDark2,
                      ),
                    ),
                  ),
                  Text(
                    "${currencyFormatExtension(widget.order.shipping)}",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: textDark2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(bottom: 8.sp),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Kode Unik",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: textDark2,
                      ),
                    ),
                  ),
                  Text(
                    "${widget.order.uniq}",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: textDark2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(bottom: 25.sp),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total Tagihan",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: textDark2,
                      ),
                    ),
                  ),
                  Text(
                    "${currencyFormatExtension((int.parse(widget.order.uniq) + int.parse(widget.order.total)).toString())}",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: primary1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      crossFadeState:
          !expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 300),
    );
  }

  Widget renderArrow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          !expanded
              ? Text(
                  "Detail",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: primary1,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  "Hide",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: primary1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }
}
