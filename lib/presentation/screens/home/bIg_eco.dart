import 'package:flutter/material.dart';

class EcosystemReveal extends StatelessWidget {
  const EcosystemReveal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final branches = <Map<String, dynamic>>[
      {
        'name': 'BigBolyde',
        'icon': Icons.directions_car,
        'color': theme.colorScheme.primary,
      },
      {
        'name': 'Fulfilora',
        'icon': Icons.shopping_bag,
        'color': Colors.orangeAccent,
      },
      {
        'name': 'Brickzonehub',
        'icon': Icons.extension,
        'color': Colors.greenAccent,
      },
      {
        'name': 'BigBen Design',
        'icon': Icons.palette,
        'color': Colors.purpleAccent,
      },
      {'name': 'Groundwork', 'icon': Icons.handshake, 'color': Colors.blueGrey},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDark
                ? Colors.black.withOpacity(0.9)
                : Colors.white.withOpacity(0.95),
            theme.colorScheme.primary.withOpacity(0.08),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'The Big‑E Ecosystem',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'A creative network connecting business, home, and innovation — where each branch brings its own energy.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white70 : Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Horizontal scrollable ecosystem strip
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: branches.map((branch) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutBack,
                        decoration: BoxDecoration(
                          color: (branch['color'] as Color).withOpacity(0.15),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: (branch['color'] as Color).withOpacity(
                                0.3,
                              ),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        child: Icon(
                          branch['icon'] as IconData,
                          color: branch['color'] as Color,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        branch['name'] as String,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white70 : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
