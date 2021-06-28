import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';

class BlogBannerWidget extends StatelessWidget {
  const BlogBannerWidget({
    Key key,
    @required this.label,
    @required this.image,
    @required this.onTap,
    this.paddingLeft,
    this.paddingRight,
  }) : super(key: key);

  final String label, image;
  final GestureTapCallback onTap;
  final double paddingLeft, paddingRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: SizedBox(
          width: 260.w,
          height: 140.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Stack(
              children: [
                FadeInImage(
                  placeholder: AssetImage("assets/images/placeholder.jpg"),
                  image: NetworkImage(
                    image,
                  ),
                  width: 260.w,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: "$label\n",
                        style: ralewayTextStyle.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
