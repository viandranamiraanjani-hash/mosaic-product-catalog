import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  final http.Client _client;

  ProductApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<ProductModel>> getProducts() async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/products'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Unable to load products');
    }

    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is! List) {
      throw const FormatException('Invalid products response');
    }

    return decodedData.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Invalid product item');
      }

      return ProductModel.fromJson(item);
    }).toList();
  }

  Future<ProductModel> getProductDetail(int id) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/products/$id'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Unable to load product detail');
    }

    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Invalid product detail response');
    }

    return ProductModel.fromJson(decodedData);
  }

  Future<List<String>> getCategories() async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/products/categories'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Unable to load categories');
    }

    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is! List || !decodedData.every((item) => item is String)) {
      throw const FormatException('Invalid categories response');
    }

    return List<String>.from(decodedData);
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);

    final response = await _client
        .get(Uri.parse('$_baseUrl/products/category/$encodedCategory'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Unable to load category products');
    }

    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is! List) {
      throw const FormatException('Invalid category products response');
    }

    return decodedData.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Invalid product item');
      }

      return ProductModel.fromJson(item);
    }).toList();
  }

  void dispose() {
    _client.close();
  }
}
