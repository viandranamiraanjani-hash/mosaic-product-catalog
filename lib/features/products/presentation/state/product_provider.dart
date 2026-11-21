import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider(this._repository);

  List<ProductModel> _allProducts = [];
  List<ProductModel> _categoryProducts = [];
  List<ProductModel> _products = [];
  List<String> _categories = [];

  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<ProductModel> get products => _products;
  List<String> get categories => ['All', ..._categories];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  Future<void> loadInitialData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getProducts(),
        _repository.getCategories(),
      ]);

      _allProducts = results[0] as List<ProductModel>;
      _categories = results[1] as List<String>;

      _selectedCategory = 'All';
      _searchQuery = '';
      _categoryProducts = List.from(_allProducts);

      _applySearch();
    } on TimeoutException {
      _errorMessage =
          'Connection timed out. Please check your internet connection.';
    } on SocketException {
      _errorMessage =
          'Unable to connect. Please check your internet connection.';
    } on FormatException {
      _errorMessage =
          'The product data could not be processed. Please try again.';
    } catch (_) {
      _errorMessage =
          'Something went wrong while loading products. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectCategory(String category) async {
    if (category == _selectedCategory) return;

    _selectedCategory = category;
    _searchQuery = '';
    _errorMessage = null;

    if (category == 'All') {
      _categoryProducts = List.from(_allProducts);
      _applySearch();
      notifyListeners();
      return;
    }

    _categoryProducts = [];
    _products = [];
    _isLoading = true;
    notifyListeners();

    try {
      _categoryProducts = await _repository.getProductsByCategory(category);
      _applySearch();
    } on TimeoutException {
      _errorMessage = 'Connection timed out. Please try again.';
    } on SocketException {
      _errorMessage =
          'Unable to connect. Please check your internet connection.';
    } on FormatException {
      _errorMessage = 'The product data could not be processed.';
    } catch (_) {
      _errorMessage = 'Unable to load this category. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    final source = _selectedCategory == 'All'
        ? _allProducts
        : _categoryProducts;

    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      _products = List.from(source);
      return;
    }

    _products = source.where((product) {
      return product.title.toLowerCase().contains(query);
    }).toList();
  }

  Future<ProductModel> getProductDetail(int id) {
    return _repository.getProductDetail(id);
  }

  Future<void> retry() async {
    if (_selectedCategory == 'All') {
      await loadInitialData();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categoryProducts = await _repository.getProductsByCategory(
        _selectedCategory,
      );

      _applySearch();
    } on TimeoutException {
      _errorMessage = 'Connection timed out. Please try again.';
    } on SocketException {
      _errorMessage =
          'Unable to connect. Please check your internet connection.';
    } on FormatException {
      _errorMessage = 'The product data could not be processed.';
    } catch (_) {
      _errorMessage = 'Unable to load this category. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
