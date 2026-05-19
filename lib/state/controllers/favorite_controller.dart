import '../../data/models/product.dart';

class FavoritesController {
  static final List<Product> favorites = [];

  static void toggleFavorite(Product product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
  }

  static bool isFavorite(Product product) {
    return favorites.contains(product);
  }
}
