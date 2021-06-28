part of 'extensions.dart';

String toDateString(DateTime dateTime) {
  String date = DateFormat("EEEE, dd MMMM yyyy", "id").format(dateTime);
  
  return date;
}