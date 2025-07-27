import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:recipe_app/core/error/error_handler.dart';

void main() {
  group('ErrorHandler', () {
    test('should handle DioException with connection timeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      final appError = ErrorHandler.handleError(dioError);

      expect(appError.type, equals(ErrorType.network));
      expect(appError.message, contains('Connection timeout'));
    });

    test('should handle DioException with 401 status code', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
      );

      final appError = ErrorHandler.handleError(dioError);

      expect(appError.type, equals(ErrorType.authentication));
      expect(appError.message, contains('Authentication failed'));
    });

    test('should handle DioException with 400 status code', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
        ),
      );

      final appError = ErrorHandler.handleError(dioError);

      expect(appError.type, equals(ErrorType.validation));
      expect(appError.message, contains('Bad request'));
    });

    test('should handle DioException with 500 status code', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );

      final appError = ErrorHandler.handleError(dioError);

      expect(appError.type, equals(ErrorType.network));
      expect(appError.message, contains('Server error'));
    });

    test('should handle generic exceptions', () {
      final genericError = Exception('Generic error message');
      final appError = ErrorHandler.handleError(genericError);

      expect(appError.type, equals(ErrorType.unknown));
      expect(appError.message, contains('Generic error message'));
    });

    test('should return same AppError if already an AppError', () {
      final originalError = AppError(
        type: ErrorType.database,
        message: 'Database error',
      );

      final handledError = ErrorHandler.handleError(originalError);

      expect(handledError, equals(originalError));
    });

    test('should provide user-friendly messages', () {
      final networkError = AppError(
        type: ErrorType.network,
        message: 'Technical network error',
      );

      final userMessage = ErrorHandler.getUserMessage(networkError);

      expect(userMessage, equals('Please check your internet connection and try again.'));
    });

    test('should identify retryable errors', () {
      final networkError = AppError(
        type: ErrorType.network,
        message: 'Network error',
      );

      final authError = AppError(
        type: ErrorType.authentication,
        message: 'Auth error',
      );

      expect(ErrorHandler.isRetryable(networkError), isTrue);
      expect(ErrorHandler.isRetryable(authError), isFalse);
    });
  });

  group('ErrorBoundary', () {
    test('should guard async operations successfully', () async {
      final result = await ErrorBoundary.guard(
        () async => 'success',
        operationName: 'test_operation',
      );

      expect(result, equals('success'));
    });

    test('should return fallback value on error', () async {
      final result = await ErrorBoundary.guard(
        () async => throw Exception('Test error'),
        operationName: 'test_operation',
        fallbackValue: 'fallback',
      );

      expect(result, equals('fallback'));
    });

    test('should return null on error without fallback', () async {
      final result = await ErrorBoundary.guard(
        () async => throw Exception('Test error'),
        operationName: 'test_operation',
      );

      expect(result, isNull);
    });

    test('should guard sync operations successfully', () {
      final result = ErrorBoundary.guardSync(
        () => 'success',
        operationName: 'test_operation',
      );

      expect(result, equals('success'));
    });

    test('should return fallback value on sync error', () {
      final result = ErrorBoundary.guardSync(
        () => throw Exception('Test error'),
        operationName: 'test_operation',
        fallbackValue: 'fallback',
      );

      expect(result, equals('fallback'));
    });
  });

  group('AppError', () {
    test('should create AppError with all fields', () {
      final stackTrace = StackTrace.current;
      final originalError = Exception('Original');
      
      final appError = AppError(
        type: ErrorType.network,
        message: 'Test message',
        details: 'Test details',
        originalError: originalError,
        stackTrace: stackTrace,
      );

      expect(appError.type, equals(ErrorType.network));
      expect(appError.message, equals('Test message'));
      expect(appError.details, equals('Test details'));
      expect(appError.originalError, equals(originalError));
      expect(appError.stackTrace, equals(stackTrace));
      expect(appError.timestamp, isA<DateTime>());
    });

    test('should convert to JSON', () {
      final appError = AppError(
        type: ErrorType.validation,
        message: 'Validation failed',
        details: 'Field X is required',
      );

      final json = appError.toJson();

      expect(json['type'], equals('ErrorType.validation'));
      expect(json['message'], equals('Validation failed'));
      expect(json['details'], equals('Field X is required'));
      expect(json['timestamp'], isA<String>());
    });

    test('should have readable toString', () {
      final appError = AppError(
        type: ErrorType.cache,
        message: 'Cache error',
        details: 'Cache corrupted',
      );

      final stringRepresentation = appError.toString();

      expect(stringRepresentation, contains('ErrorType.cache'));
      expect(stringRepresentation, contains('Cache error'));
      expect(stringRepresentation, contains('Cache corrupted'));
    });
  });
}