class AppGlobalException implements Exception {
  final String message;

  AppGlobalException(
    this.message,
  );

  @override
  String toString() {
    return 'AppGlobalException message: $message';
  }
}
