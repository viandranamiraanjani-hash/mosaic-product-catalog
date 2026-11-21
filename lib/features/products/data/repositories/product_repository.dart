import '../models/product_model.dart';
import '../sources/product_api_service.dart';

class ProductRepository {
  final ProductApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<ProductModel>> getProducts() {
    return _apiService.getProducts();
  }

  Future<ProductModel> getProductDetail(int id) {
    return _apiService.getProductDetail(id);
  }

  Future<List<String>> getCategories() {
    return _apiService.getCategories();
  }

  Future<List<ProductModel>> getProductsByCategory(String category) {
    return _apiService.getProductsByCategory(category);
  }

  void dispose() {
    _apiService.dispose();
  }
}
