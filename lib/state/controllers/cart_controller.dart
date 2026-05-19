import 'package:flutter/material.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(
        CartItem(
          id: product.id,
          name: product.name,
          image: product.assetImage,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  double get total {
    return _items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}
