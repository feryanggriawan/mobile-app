part of 'extensions.dart';

String currencyFormatExtension(String number) {
  return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
      .format(int.parse(number));
}
