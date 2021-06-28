import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/shared/shared.dart';

class OrderProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String total;

  const OrderProductItem({Key key, this.imageUrl, this.name, this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80.sp,
          width: 80.sp,
          child: Image.network(imageUrl, fit: BoxFit.cover,),
        ),
        SizedBox(width: 10.sp,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: ralewayTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),
              SizedBox(height: 8.sp,),
              Text(
                currencyFormatExtension(total),
                style: ralewayTextStyle.copyWith(
                  color: primary1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
