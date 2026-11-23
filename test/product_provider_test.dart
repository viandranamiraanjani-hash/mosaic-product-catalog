import 'package:flutter_test/flutter_test.dart';

import 'package:product_catalog/features/products/data/models/product_model.dart';
import 'package:product_catalog/features/products/data/repositories/product_repository.dart';
import 'package:product_catalog/features/products/data/sources/product_api_service.dart';
import 'package:product_catalog/features/products/presentation/state/product_provider.dart';

class EmptyProductRepository extends ProductRepository {
  EmptyProductRepository() : super(ProductApiService());

  @override
  Future<List<ProductModel>> getProducts() async {
    return [];
  }

  @override
  Future<List<String>> getCategories() async {
    return [];
  }

  @override
  void dispose() {}
}

void main() {
  group('ProductProvider Empty State', () {
    test('should handle an empty product list without an error', () async {
      final repository = EmptyProductRepository();
      final provider = ProductProvider(repository);

      await provider.loadInitialData();

      expect(provider.products, isEmpty);
      expect(provider.errorMessage, isNull);
      expect(provider.isLoading, isFalse);

      provider.dispose();
    });
  });
}
