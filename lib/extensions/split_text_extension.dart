part of 'extensions.dart';

List<String> splitTextExtension(String text, String split) {
  List<String> results = text.split('$split');
  results.removeAt(0);
  return results;
}
