class FailFetchDataException implements Exception {
  final String message;

  FailFetchDataException({required this.message});

  @override
  String toString() {
    return 'FailFetchDataException: $message';
  }
}
