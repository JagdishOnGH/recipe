import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

enum ErrorType {
  network,
  cache,
  database,
  authentication,
  validation,
  unknown,
}

class AppError {
  final ErrorType type;
  final String message;
  final String? details;
  final dynamic originalError;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  AppError({
    required this.type,
    required this.message,
    this.details,
    this.originalError,
    this.stackTrace,
  }) : timestamp = DateTime.now();

  @override
  String toString() {
    return 'AppError(type: $type, message: $message, details: $details)';
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'message': message,
      'details': details,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class ErrorHandler {
  static final Logger _logger = Logger();

  /// Handle and convert various error types to AppError
  static AppError handleError(dynamic error, [StackTrace? stackTrace]) {
    _logger.e('Error occurred: $error', stackTrace: stackTrace);

    if (error is DioException) {
      return _handleDioError(error, stackTrace);
    } else if (error is AppError) {
      return error;
    } else {
      return AppError(
        type: ErrorType.unknown,
        message: error.toString(),
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  static AppError _handleDioError(DioException error, StackTrace? stackTrace) {
    String message;
    String? details;
    ErrorType type = ErrorType.network;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Server response timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            message = 'Bad request. Please check your input.';
            type = ErrorType.validation;
            break;
          case 401:
            message = 'Authentication failed. Please login again.';
            type = ErrorType.authentication;
            break;
          case 403:
            message = 'Access forbidden. You don\'t have permission.';
            type = ErrorType.authentication;
            break;
          case 404:
            message = 'Resource not found.';
            break;
          case 429:
            message = 'Too many requests. Please try again later.';
            break;
          case 500:
            message = 'Server error. Please try again later.';
            break;
          default:
            message = 'Server error (${statusCode ?? 'Unknown'}). Please try again.';
        }
        details = error.response?.data?.toString();
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badCertificate:
        message = 'Security certificate error.';
        break;
      case DioExceptionType.unknown:
      default:
        message = 'Network error occurred. Please try again.';
    }

    return AppError(
      type: type,
      message: message,
      details: details,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Log error for analytics/crash reporting
  static void logError(AppError error) {
    if (kDebugMode) {
      _logger.e(
        'AppError: ${error.type} - ${error.message}',
        error: error.originalError,
        stackTrace: error.stackTrace,
      );
    }

    // In production, you would send this to your error tracking service
    // like Firebase Crashlytics, Sentry, etc.
    // _sendToCrashlytics(error);
  }

  /// Get user-friendly error message
  static String getUserMessage(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return 'Please check your internet connection and try again.';
      case ErrorType.cache:
        return 'There was a problem loading cached data.';
      case ErrorType.database:
        return 'There was a problem accessing stored data.';
      case ErrorType.authentication:
        return 'Please log in again to continue.';
      case ErrorType.validation:
        return error.message;
      case ErrorType.unknown:
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  /// Check if error is retryable
  static bool isRetryable(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return true;
      case ErrorType.cache:
        return false;
      case ErrorType.database:
        return false;
      case ErrorType.authentication:
        return false;
      case ErrorType.validation:
        return false;
      case ErrorType.unknown:
        return true;
    }
  }
}

class ErrorBoundary {
  static final Logger _logger = Logger();

  /// Wrap operations that might throw errors
  static Future<T?> guard<T>(
    Future<T> Function() operation, {
    String? operationName,
    T? fallbackValue,
    bool logError = true,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      final appError = ErrorHandler.handleError(error, stackTrace);
      
      if (logError) {
        _logger.e(
          'Error in ${operationName ?? 'operation'}: ${appError.message}',
          error: error,
          stackTrace: stackTrace,
        );
        ErrorHandler.logError(appError);
      }

      return fallbackValue;
    }
  }

  /// Wrap synchronous operations
  static T? guardSync<T>(
    T Function() operation, {
    String? operationName,
    T? fallbackValue,
    bool logError = true,
  }) {
    try {
      return operation();
    } catch (error, stackTrace) {
      final appError = ErrorHandler.handleError(error, stackTrace);
      
      if (logError) {
        _logger.e(
          'Error in ${operationName ?? 'operation'}: ${appError.message}',
          error: error,
          stackTrace: stackTrace,
        );
        ErrorHandler.logError(appError);
      }

      return fallbackValue;
    }
  }
}