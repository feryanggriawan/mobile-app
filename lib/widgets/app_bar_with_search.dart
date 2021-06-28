import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/shared/shared.dart';

class AppBarWithSearchWidget extends StatelessWidget {
  final ValueChanged<dynamic> onFieldSubmitted;
  final GestureTapCallback onTap;
  final TextEditingController textEditingController;

  const AppBarWithSearchWidget(
      {Key key,
      @required this.onFieldSubmitted,
      @required this.onTap,
      @required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        children: [
          if (Navigator.canPop(context))
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin, vertical: 5.h),
              child: TextFormField(
                onFieldSubmitted: onFieldSubmitted,
                onSaved: (value) {},
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      margin: EdgeInsets.all(6.h),
                      child: Icon(
                        textEditingController.text.isEmpty
                            ? Icons.search
                            : Icons.close,
                        color: Colors.white,
                        size: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: textEditingController.text.isEmpty
                            ? Colors.orange
                            : Colors.red,
                        borderRadius: BorderRadius.circular(50.h),
                      ),
                    ),
                  ),
                  hintText: 'Search...',
                  hintStyle: ralewayTextStyle.copyWith(
                      fontSize: 12.sp, color: textDark3),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
                ),
                controller: textEditingController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
