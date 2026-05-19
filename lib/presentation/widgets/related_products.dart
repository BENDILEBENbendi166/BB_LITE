import 'package:bigbolyde_lite/data/models/product.dart';
import 'package:bigbolyde_lite/presentation/widgets/product_card.dart';
import 'package:bigbolyde_lite/state/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatedProductsWidget extends StatelessWidget {
  final Product product;

  const RelatedProductsWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();

    final related = controller.allProducts.where((p) {
      return p.id != product.id &&
          (p.name == product.name || p.category == product.category);
    }).toList();

    if (related.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No related products found.'),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: related.length,
        itemBuilder: (_, i) {
          final item = related[i];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(left: 16),
            child: ProductCard(product: item),
          );
        },
      ),
    );
  }
}
