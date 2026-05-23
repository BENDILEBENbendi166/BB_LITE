import 'package:bigbolyde_lite/core/theme/app_theme.dart';
import 'package:bigbolyde_lite/presentation/screens/home/bIg_eco.dart';
import 'package:bigbolyde_lite/presentation/screens/home/footer_screen.dart';
import 'package:bigbolyde_lite/presentation/screens/home/hero_screen.dart';
import 'package:bigbolyde_lite/state/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../state/controllers/product_controller.dart';
import '../../widgets/product_card.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/category_chips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = ProductRepository();

  @override
  void initState() {
    super.initState();
    repo.loadProducts().then((products) {
      if (!mounted) return;
      context.read<ProductController>().setProducts(products);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              ),
              child: Row(
                children: [
                  Image.asset('assets/logo/Logo.png', height: 36),
                  const SizedBox(width: 8),
                  Text(
                    'BigBolyde Lite',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeController>().toggleTheme(),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.darkStart, AppTheme.darkEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // HERO + SEARCH + CHIPS
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeroBanner(),
                    const EcosystemReveal(),
                    const SizedBox(height: 20),

                    // SEARCH BAR
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: SearchBarWidget(
                        onChanged: controller.updateSearch,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CATEGORY CHIPS
                    CategoryChips(
                      categories: const [
                        'All',
                        'Gaming',
                        'Outdoor',
                        'Home',
                        'Lifestyle',
                        'Toys',
                        'Pets',
                      ],
                      selected: controller.selectedCategory,
                      onSelected: controller.updateCategory,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // PRODUCT GRID
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate((context, i) {
                  return AnimatedOpacity(
                    opacity: 1,
                    duration: Duration(milliseconds: 300 + (i * 40)),
                    child: ProductCard(product: controller.filteredProducts[i]),
                  );
                }, childCount: controller.filteredProducts.length),
              ),
            ),

            // FOOTER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: const FooterSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
