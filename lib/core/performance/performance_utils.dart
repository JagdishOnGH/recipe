import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class PerformanceMonitor {
  static final Logger _logger = Logger();
  static final Map<String, DateTime> _startTimes = {};

  /// Start timing an operation
  static void startTimer(String operationName) {
    if (kDebugMode) {
      _startTimes[operationName] = DateTime.now();
      _logger.d('⏱️ Started timing: $operationName');
    }
  }

  /// End timing an operation and log the duration
  static void endTimer(String operationName) {
    if (kDebugMode) {
      final endTime = DateTime.now();
      final startTime = _startTimes[operationName];
      
      if (startTime != null) {
        final duration = endTime.difference(startTime);
        _logger.i('⏱️ $operationName took: ${duration.inMilliseconds}ms');
        _startTimes.remove(operationName);
        
        // Warn if operation takes too long
        if (duration.inMilliseconds > 1000) {
          _logger.w('⚠️ Slow operation detected: $operationName (${duration.inMilliseconds}ms)');
        }
      } else {
        _logger.w('⚠️ Timer not found for: $operationName');
      }
    }
  }

  /// Time a future operation
  static Future<T> timeOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    startTimer(operationName);
    try {
      final result = await operation();
      endTimer(operationName);
      return result;
    } catch (e) {
      endTimer(operationName);
      _logger.e('❌ Operation failed: $operationName - $e');
      rethrow;
    }
  }

  /// Memory usage monitoring
  static void logMemoryUsage(String context) {
    if (kDebugMode) {
      // This is a simplified memory logging
      // In production, you might want to use more sophisticated monitoring
      _logger.d('📊 Memory check at: $context');
    }
  }
}

class ImageOptimizationHelper {
  /// Get optimized image URL with size parameters
  static String getOptimizedImageUrl(
    String originalUrl, {
    int? width,
    int? height,
    int quality = 80,
  }) {
    // This is a generic approach - you might need to adjust based on your image service
    if (originalUrl.isEmpty) return originalUrl;
    
    // For many image services, you can add query parameters
    final uri = Uri.tryParse(originalUrl);
    if (uri == null) return originalUrl;
    
    final queryParams = Map<String, String>.from(uri.queryParameters);
    
    if (width != null) queryParams['w'] = width.toString();
    if (height != null) queryParams['h'] = height.toString();
    queryParams['q'] = quality.toString();
    
    return uri.replace(queryParameters: queryParams).toString();
  }

  /// Get thumbnail URL for recipe images
  static String getThumbnailUrl(String originalUrl) {
    return getOptimizedImageUrl(
      originalUrl,
      width: 300,
      height: 200,
      quality: 70,
    );
  }

  /// Get full size optimized URL for recipe detail images
  static String getFullSizeUrl(String originalUrl) {
    return getOptimizedImageUrl(
      originalUrl,
      width: 800,
      height: 600,
      quality: 85,
    );
  }
}

class PaginationHelper {
  /// Calculate pagination parameters
  static PaginationParams calculatePagination({
    required int currentPage,
    required int itemsPerPage,
    int totalItems = 0,
  }) {
    final offset = (currentPage - 1) * itemsPerPage;
    final totalPages = totalItems > 0 ? (totalItems / itemsPerPage).ceil() : 0;
    
    return PaginationParams(
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
      offset: offset,
      totalPages: totalPages,
      hasNextPage: currentPage < totalPages,
      hasPreviousPage: currentPage > 1,
    );
  }

  /// Check if we should load more items (for infinite scroll)
  static bool shouldLoadMore({
    required int currentItemCount,
    required int totalItems,
    required int threshold,
  }) {
    if (totalItems == 0) return true; // First load
    return currentItemCount < totalItems && 
           (totalItems - currentItemCount) <= threshold;
  }
}

class PaginationParams {
  final int currentPage;
  final int itemsPerPage;
  final int offset;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginationParams({
    required this.currentPage,
    required this.itemsPerPage,
    required this.offset,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  String toString() {
    return 'PaginationParams(page: $currentPage/$totalPages, '
           'itemsPerPage: $itemsPerPage, offset: $offset)';
  }
}

class LazyLoadingController {
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  final int itemsPerPage;

  LazyLoadingController({this.itemsPerPage = 10});

  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  int get currentPage => _currentPage;

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  void setHasMoreData(bool hasMore) {
    _hasMoreData = hasMore;
  }

  void nextPage() {
    _currentPage++;
  }

  void reset() {
    _currentPage = 1;
    _hasMoreData = true;
    _isLoading = false;
  }

  PaginationParams getPaginationParams() {
    return PaginationHelper.calculatePagination(
      currentPage: _currentPage,
      itemsPerPage: itemsPerPage,
    );
  }
}