import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      color: isDark
          ? Colors.black.withOpacity(0.3)
          : Colors.white.withOpacity(0.9),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'About BIG BOLYDE',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'BIG BOLYDE is part of the Big‑E ecosystem — connecting business, home, and lifestyle innovation. '
              'Born from automotive roots, it now curates trusted products across gaming, tech, and everyday living — '
              'blending performance, design, and reliability.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
              child: const Text('Learn more'),
            ),
          ],
        ),
      ),
    );
  }
}
