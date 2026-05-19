import 'package:bigbolyde_lite/core/theme/app_theme.dart';
import 'package:bigbolyde_lite/presentation/screens/cart/cart_screen.dart';
import 'package:bigbolyde_lite/presentation/screens/home/home_screen.dart';
import 'package:bigbolyde_lite/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:bigbolyde_lite/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:bigbolyde_lite/presentation/screens/splash/splash_screen.dart';
import 'package:bigbolyde_lite/state/controllers/cart_controller.dart';
import 'package:bigbolyde_lite/state/controllers/product_controller.dart';
import 'package:bigbolyde_lite/state/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const BigBolydeLite());
}

class BigBolydeLite extends StatelessWidget {
  const BigBolydeLite({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: Builder(
        builder: (context) {
          final theme = context.watch<ThemeController>();

          return MaterialApp(
            title: 'BigBolyde Lite',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (_) => const SplashScreen(),
              '/onboarding': (_) => const OnboardingScreen(),
              '/home': (_) => const HomeScreen(),
              '/detail': (_) => const ProductDetailScreen(),
              '/cart': (_) => const CartScreen(),
            },
          );
        },
      ),
    );
  }
}
