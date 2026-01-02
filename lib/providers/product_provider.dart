import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> filtered = [];
  bool isLoading = false;

  List<Product> get products => filtered;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await ApiClient.dio.get('/products');
      _products = (res.data as List).map((e) => Product.fromJson(e)).toList();
      filtered = _products;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void search(String keyword) {
    if (keyword.trim().isEmpty) {
      filtered = _products;
    } else {
      final k = keyword.toLowerCase();
      filtered = _products
          .where((p) => p.name.toLowerCase().contains(k))
          .toList();
    }
    notifyListeners();
  }

  Product? getById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
