part of 'extensions.dart';

bool checkDiscountExtension({String basePrice, String price}) {
  bool isDiscount = false;

  if (int.parse(basePrice) > int.parse(price)) {
    isDiscount = true;
  }

  return isDiscount;
}
