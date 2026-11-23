import 'package:flutter/foundation.dart';

import '../../data/models/cart_item.dart';
import '../../../products/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount {
    return _items.values.fold(0, (total, item) => total + item.quantity);
  }

  int get uniqueItemCount => _items.length;

  double get subtotal {
    return _items.values.fold(0, (total, item) => total + item.totalPrice);
  }

  double get total => subtotal;

  bool get isEmpty => _items.isEmpty;

  bool containsProduct(int productId) {
    return _items.containsKey(productId);
  }

  int quantityOf(int productId) {
    return _items[productId]?.quantity ?? 0;
  }

  void addProduct(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }

    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final item = _items[productId];

    if (item == null) return;

    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    final item = _items[productId];

    if (item == null) return;

    if (item.quantity <= 1) {
      _items.remove(productId);
    } else {
      item.quantity--;
    }

    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
