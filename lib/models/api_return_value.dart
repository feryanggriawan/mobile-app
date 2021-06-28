

class ApiReturnValue<T> {
  final T value;
  final String message;
  final int code;

  ApiReturnValue({this.message, this.value, this.code});
}
