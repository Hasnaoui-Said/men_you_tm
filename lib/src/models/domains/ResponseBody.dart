class ResponseBody<T> {
  final bool success;
  final String message;
  final T data;

  ResponseBody({this.success = false, this.message = "", required this.data} );
}
