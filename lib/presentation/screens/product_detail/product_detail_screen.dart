import 'package:bigbolyde_lite/presentation/screens/home/footer_screen.dart';
import 'package:bigbolyde_lite/presentation/widgets/related_products.dart';
import 'package:bigbolyde_lite/state/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: _BottomBar(product: product),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER WITH GRADIENT
            Stack(
              children: [
                Hero(
                  tag: product.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Image.asset(
                      product.assetImage,
                      height: 340,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // GRADIENT OVERLAY
                Container(
                  height: 340,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                // CATEGORY BADGE
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // ADD TO CART + SHARE BUTTONS
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Row(
                    children: [
                      _addToCartButton(product),
                      const SizedBox(width: 12),
                      _shareButton(product.affiliateLink),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // TITLE + PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.advertiser,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // DESCRIPTION CARD
            _sectionCard(
              context,
              title: "Description",
              child: Text(
                product.description,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
              ),
            ),

            const SizedBox(height: 20),

            // FEATURES CARD
            if (product.features != null)
              _sectionCard(
                context,
                title: "Features",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: product.features!
                      .map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "• $f",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

            const SizedBox(height: 28),

            // RELATED PRODUCTS TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Related Products",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // RELATED PRODUCTS WIDGET
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RelatedProductsWidget(product: product),
            ),

            const SizedBox(height: 140), // space for sticky bar
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  // ADD TO CART BUTTON
  Widget _addToCartButton(Product product) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        elevation: 2,
      ),
      onPressed: () {
        // Add the product to the cart using the CartController
        context.read<CartController>().addToCart(product);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Added to cart')));
      },
      child: const Icon(Icons.add_shopping_cart, size: 22),
    );
  }

  // SHARE BUTTON (COPY TO CLIPBOARD)
  Widget _shareButton(String affiliateLink) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white24,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        elevation: 2,
      ),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: affiliateLink));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Affiliate link copied!')));
      },
      child: const Icon(Icons.share, size: 22),
    );
  }

  // SECTION CARD
  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// STICKY BOTTOM BAR
class _BottomBar extends StatelessWidget {
  final Product product;
  const _BottomBar({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "\$${product.price}",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final url = Uri.parse(product.affiliateLink);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text("More Info"),
          ),
        ],
      ),
    );
  }
}
