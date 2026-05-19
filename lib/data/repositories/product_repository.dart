import 'dart:convert';

import 'package:bigbolyde_lite/data/models/product.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';

class ProductRepository {
  Future<List<Product>> loadProducts() async {
    final box = await Hive.openBox('cache');

    try {
      final data = await rootBundle.loadString('assets/products.json');
      box.put('products', data);
      return _parse(data);
    } catch (_) {
      final cached = box.get('products');
      if (cached != null) {
        return _parse(cached);
      }
      return [];
    }
  }

  List<Product> _parse(String data) {
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((e) => Product.fromJson(e)).toList();
  }
}
