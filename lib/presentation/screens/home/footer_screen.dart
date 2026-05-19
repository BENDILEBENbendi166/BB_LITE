import 'package:flutter/material.dart';
import 'package:bigbolyde_lite/core/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ignore: unused_local_variable
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.darkStart, AppTheme.darkEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 1,
            width: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.glowBlue.withOpacity(0.6),
                  AppTheme.glowBlue.withOpacity(0.1),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '© 2026 BIG BOLYDE — All rights reserved.',
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 4),
          Text(
            'Built with clarity, performance, and a passion for better experiences.',
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 4),
          Text(
            'Part of the BigBen Projects ecosystem.',
            style: TextStyle(color: Colors.white.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }
}
