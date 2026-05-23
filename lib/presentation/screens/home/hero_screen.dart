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
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Discover curated products that blend performance, design, and everyday reliability.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white54 : Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          // LEARN MORE BUTTON — more inviting, with a subtle shadow
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              shadowColor: theme.colorScheme.primary.withOpacity(0.4),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: isDark ? Colors.black87 : Colors.white,
                  title: Text('About BIG BOLYDE'),
                  content: Text(
                    'BIG BOLYDE started as a vision of performance — inspired by the automotive world. '
                    'Today, it’s a growing brand within the Big‑E ecosystem, offering a curated gateway to quality products '
                    'from local and international brands. Our philosophy is simple: clarity, trust, and value. '
                    'As we expand, the automotive branch will return, completing the full circle of innovation we stand for.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white70 : Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'LEARN MORE',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
