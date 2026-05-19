import 'dart:ui';

import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse, // ✅ add mouse support
          },
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  _buildPage(
                    context,
                    icon: Icons.explore_rounded,
                    title: 'Discover Products You Love',
                    subtitle: 'Explore curated items from around the world.',
                  ),
                  _buildPage(
                    context,
                    icon: Icons.public_rounded,
                    title: 'Shop Smart. Shop Global.',
                    subtitle: 'Find the best deals with ease.',
                  ),
                  _buildPage(
                    context,
                    icon: Icons.shopping_bag_rounded,
                    title: 'Start Exploring',
                    subtitle: 'Your journey begins now.',
                    isLast: true,
                    onStart: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              ),
            ),

            // 👇 Navigation arrows for desktop users
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    bool isLast = false,
    VoidCallback? onStart,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ICON CONTAINER
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, size: 72, color: theme.colorScheme.primary),
          ),

          const SizedBox(height: 40),

          // TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          // SUBTITLE
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.4,
            ),
          ),

          if (isLast) ...[
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Get Started'),
            ),
          ],
        ],
      ),
    );
  }
}
