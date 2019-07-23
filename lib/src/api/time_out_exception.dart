class TimeoutException implements Exception {
  final int code;
  final String message;
  final Duration duration;

  TimeoutException(this.code, this.message, this.duration)
      : assert(code != null);

  @override
  String toString() {
    return 'TimeoutException{code: $code, message: $message, duration: $duration}';
  }
}
