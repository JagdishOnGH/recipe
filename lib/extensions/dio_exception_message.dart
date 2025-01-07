import 'package:dio/dio.dart';

String handleDioException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.cancel:
      return "Request to the server was cancelled.";
    case DioExceptionType.connectionTimeout:
      return "Connection timed out. Please check your internet connection.";
    case DioExceptionType.sendTimeout:
      return "Request send timed out. Please try again later.";
    case DioExceptionType.receiveTimeout:
      return "Server took too long to respond. Please try again.";
    case DioExceptionType.badResponse:
      final statusCode = exception.response?.statusCode;
      if (statusCode != null) {
        return "Received invalid status code: $statusCode.";
      }
      return "Received a bad response from the server.";
    case DioExceptionType.connectionError:
      return "Could not connect to the server. Please check your internet.";
    case DioExceptionType.unknown:
      return "An unexpected error occurred. Please try again.";
    default:
      return "An error occurred. Please try again.";
  }
}
