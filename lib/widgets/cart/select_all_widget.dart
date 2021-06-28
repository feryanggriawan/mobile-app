import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartSelectAllWidget extends StatelessWidget {
  final bool chooseAll;
  final ValueChanged<bool> onChanged;
  final GestureTapCallback onDelete;

  const CartSelectAllWidget({Key key, this.chooseAll, this.onChanged, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Checkbox(
            value: chooseAll,
            onChanged: (v) {
              onChanged(v);
            },
            activeColor: primary1,
          ),
          width: 20.sp,
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: Text(
            "Pilih Semua",
            style: playfairDisplayTextStyle.copyWith(
              color: textDark2,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        GestureDetector(
          onTap: onDelete,
          child: Text(
            "Hapus",
            style: ralewayTextStyle.copyWith(
              color: primary2,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }
}
