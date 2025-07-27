import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/core/performance/performance_utils.dart';

void main() {
  group('PerformanceMonitor', () {
    test('should track operation timing', () {
      PerformanceMonitor.startTimer('test_operation');
      // Simulate some work
      PerformanceMonitor.endTimer('test_operation');
      // No exception should be thrown
    });

    test('should handle missing timer gracefully', () {
      expect(() => PerformanceMonitor.endTimer('nonexistent_timer'),
          returnsNormally);
    });

    test('should time async operations', () async {
      final result = await PerformanceMonitor.timeOperation(
        'async_test',
        () async {
          await Future.delayed(Duration(milliseconds: 10));
          return 'test_result';
        },
      );

      expect(result, equals('test_result'));
    });

    test('should handle errors in timed operations', () async {
      expect(
        () => PerformanceMonitor.timeOperation(
          'error_test',
          () async {
            throw Exception('Test error');
          },
        ),
        throwsException,
      );
    });
  });

  group('ImageOptimizationHelper', () {
    test('should generate optimized image URL', () {
      const originalUrl = 'https://example.com/image.jpg';
      final optimizedUrl = ImageOptimizationHelper.getOptimizedImageUrl(
        originalUrl,
        width: 300,
        height: 200,
        quality: 80,
      );

      expect(optimizedUrl, contains('w=300'));
      expect(optimizedUrl, contains('h=200'));
      expect(optimizedUrl, contains('q=80'));
    });

    test('should handle empty URL', () {
      final result = ImageOptimizationHelper.getOptimizedImageUrl('');
      expect(result, equals(''));
    });

    test('should generate thumbnail URL', () {
      const originalUrl = 'https://example.com/image.jpg';
      final thumbnailUrl = ImageOptimizationHelper.getThumbnailUrl(originalUrl);

      expect(thumbnailUrl, contains('w=300'));
      expect(thumbnailUrl, contains('h=200'));
    });

    test('should generate full size URL', () {
      const originalUrl = 'https://example.com/image.jpg';
      final fullSizeUrl = ImageOptimizationHelper.getFullSizeUrl(originalUrl);

      expect(fullSizeUrl, contains('w=800'));
      expect(fullSizeUrl, contains('h=600'));
    });
  });

  group('PaginationHelper', () {
    test('should calculate pagination correctly', () {
      final params = PaginationHelper.calculatePagination(
        currentPage: 2,
        itemsPerPage: 10,
        totalItems: 50,
      );

      expect(params.currentPage, equals(2));
      expect(params.itemsPerPage, equals(10));
      expect(params.offset, equals(10));
      expect(params.totalPages, equals(5));
      expect(params.hasNextPage, isTrue);
      expect(params.hasPreviousPage, isTrue);
    });

    test('should handle first page correctly', () {
      final params = PaginationHelper.calculatePagination(
        currentPage: 1,
        itemsPerPage: 10,
        totalItems: 50,
      );

      expect(params.currentPage, equals(1));
      expect(params.offset, equals(0));
      expect(params.hasPreviousPage, isFalse);
      expect(params.hasNextPage, isTrue);
    });

    test('should handle last page correctly', () {
      final params = PaginationHelper.calculatePagination(
        currentPage: 5,
        itemsPerPage: 10,
        totalItems: 50,
      );

      expect(params.currentPage, equals(5));
      expect(params.hasNextPage, isFalse);
      expect(params.hasPreviousPage, isTrue);
    });

    test('should determine when to load more items', () {
      final shouldLoad = PaginationHelper.shouldLoadMore(
        currentItemCount: 45,
        totalItems: 50,
        threshold: 10,
      );

      expect(shouldLoad, isTrue);
    });

    test('should not load more when enough items cached', () {
      final shouldLoad = PaginationHelper.shouldLoadMore(
        currentItemCount: 30,
        totalItems: 50,
        threshold: 10,
      );

      expect(shouldLoad, isFalse);
    });
  });

  group('LazyLoadingController', () {
    late LazyLoadingController controller;

    setUp(() {
      controller = LazyLoadingController(itemsPerPage: 10);
    });

    test('should initialize with correct default values', () {
      expect(controller.isLoading, isFalse);
      expect(controller.hasMoreData, isTrue);
      expect(controller.currentPage, equals(1));
    });

    test('should update loading state', () {
      controller.setLoading(true);
      expect(controller.isLoading, isTrue);

      controller.setLoading(false);
      expect(controller.isLoading, isFalse);
    });

    test('should update hasMoreData state', () {
      controller.setHasMoreData(false);
      expect(controller.hasMoreData, isFalse);

      controller.setHasMoreData(true);
      expect(controller.hasMoreData, isTrue);
    });

    test('should increment page number', () {
      controller.nextPage();
      expect(controller.currentPage, equals(2));

      controller.nextPage();
      expect(controller.currentPage, equals(3));
    });

    test('should reset to initial state', () {
      controller.nextPage();
      controller.setLoading(true);
      controller.setHasMoreData(false);

      controller.reset();

      expect(controller.currentPage, equals(1));
      expect(controller.isLoading, isFalse);
      expect(controller.hasMoreData, isTrue);
    });

    test('should generate correct pagination params', () {
      controller.nextPage(); // page 2
      final params = controller.getPaginationParams();

      expect(params.currentPage, equals(2));
      expect(params.itemsPerPage, equals(10));
      expect(params.offset, equals(10));
    });
  });
}