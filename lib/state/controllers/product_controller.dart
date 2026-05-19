import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class ProductController extends ChangeNotifier {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];

  String searchQuery = '';
  String selectedCategory = 'All';

  void setProducts(List<Product> products) {
    allProducts = products;
    filteredProducts = products;
    notifyListeners();
  }

  void updateSearch(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void updateCategory(String category) {
    selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    filteredProducts = allProducts.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == 'All' ||
          product.category.toLowerCase().contains(
            selectedCategory.toLowerCase(),
          );
      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }
}
