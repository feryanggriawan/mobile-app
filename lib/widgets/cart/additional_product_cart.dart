import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/product_pages/detail_product_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';

class AdditionalProductCart extends StatelessWidget {
  final ProductModel productModel;
  final GestureTapCallback onTap;

  const AdditionalProductCart({Key key, this.productModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 180.w,
        margin: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              child: FadeInImage(
                height: 113.w,
                width: 156.w,
                placeholder: AssetImage("assets/images/placeholder.jpg"),
                image: NetworkImage(
                  productModel.images[0].file,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: playfairDisplayTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        color: textDark1),
                  ),
                  SizedBox(height: 8.w),
                  (productModel.isDiscount)
                      ? Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.w, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  color: secondary6,
                                  borderRadius: BorderRadius.circular(100.r)),
                              child: Text(
                                "Disc",
                                style: ralewayTextStyle.copyWith(
                                    fontSize: 8.sp, color: secondary1),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text("${productModel.basePrice}",
                                style: ralewayTextStyle.copyWith(
                                    color: textDark3,
                                    fontSize: 8.sp,
                                    decoration: TextDecoration.lineThrough)),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 4.w),
                  Text(
                    " ${currencyFormatExtension(productModel.price)}",
                    style: ralewayTextStyle.copyWith(
                      color: primary1,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ButtonIconWidget(
                      height: 28.w,
                      label: Text(" Masuk Keranjang",
                          style: ralewayTextStyle.copyWith(
                              color: bgLight2, fontSize: 8.sp)),
                      iconLeft: Icon(
                        UniconsLine.shopping_cart,
                        size: 10.sp,
                        color: textLight2,
                      ),
                      onTap: onTap,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Get.to(
          DetailProductPage(
            productModel,
          ),
        );
      },
    );
  }
}
