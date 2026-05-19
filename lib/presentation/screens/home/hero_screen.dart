import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.12),
            theme.colorScheme.primary.withOpacity(0.04),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // LOGO — cleaner, more breathable
          AnimatedScale(
            scale: 1,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutBack,
            child: Image.asset(
              'assets/logo/Logo.png',
              height: 100,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),

          // BRAND NAME — cleaner glow, theme-aware
          Text(
            'BIG BOLYDE',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: theme.colorScheme.primary,
              shadows: [
                Shadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 14,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // TRUST MESSAGE — softer, more premium
          Text(
            'Trusted picks. Clear value. No noise.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white70 : Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // SUPPORTING LINE — lighter, more elegant
          Text(
            'Your curated gateway to gaming, tech, home & lifestyle.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white54 : Colors.white54,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
