import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:product_catalog/features/products/data/sources/product_api_service.dart';

void main() {
  group('ProductApiService malformed response tests', () {
    test('throws FormatException when API returns invalid JSON', () async {
      final client = MockClient((request) async {
        return http.Response('invalid json', 200);
      });

      final apiService = ProductApiService(client: client);
      addTearDown(apiService.dispose);

      await expectLater(
        apiService.getProducts(),
        throwsA(isA<FormatException>()),
      );
    });

    test(
      'throws FormatException when product response is not a list',
      () async {
        final client = MockClient((request) async {
          return http.Response('{"message":"Invalid response"}', 200);
        });

        final apiService = ProductApiService(client: client);
        addTearDown(apiService.dispose);

        await expectLater(
          apiService.getProducts(),
          throwsA(isA<FormatException>()),
        );
      },
    );

    test(
      'throws FormatException when product data has invalid fields',
      () async {
        final client = MockClient((request) async {
          return http.Response('''
          [
            {
              "id": "invalid",
              "title": "Test Product",
              "price": 10.0,
              "description": "Test description",
              "category": "electronics",
              "image": "https://example.com/image.jpg",
              "rating": {
                "rate": 4.5,
                "count": 10
              }
            }
          ]
          ''', 200);
        });

        final apiService = ProductApiService(client: client);
        addTearDown(apiService.dispose);

        await expectLater(
          apiService.getProducts(),
          throwsA(isA<FormatException>()),
        );
      },
    );
  });
}
