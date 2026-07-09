import 'package:flutter/material.dart';

class OpenSourceLicensesScreen extends StatelessWidget {
  const OpenSourceLicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // A map of major standard packages typically running within advanced navigation configurations
    final List<Map<String, String>> dependencyLicenses = [
      {
        'name': 'Flutter SDK',
        'type': 'BSD 3-Clause License',
        'desc': 'Core framework components, engine compilers, architecture configurations, and material rendering layers.',
      },
      {
        'name': 'Path Provider',
        'type': 'BSD 3-Clause License',
        'desc': 'Locates spatial memory points across system directories to manage compressed binary graph allocations offline.',
      },
      {
        'name': 'Isar / Hive Database',
        'type': 'Apache License 2.0',
        'desc': 'High-performance, transactional local NoSQL store serving offline transit timetables and saved routes instantly.',
      },
      {
        'name': 'Google Fonts',
        'type': 'OFL / Apache 2.0',
        'desc': 'Dynamically interfaces programmatic typographical configurations rendering optimized clean text weights across devices.',
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Open Source & Licenses',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          itemCount: dependencyLicenses.length + 2, // Includes dynamic header and full system license action button
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MARK is built using free, open-source architectures. We are deeply grateful to the open-source community for providing the underlying tools that power this journey planner.',
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Primary Project Dependencies',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }

            // Action button placed safely at the very bottom of the scrolling list view items array
            if (index == dependencyLicenses.length + 1) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
                child: Column(
                  children: [
                    Divider(color: theme.dividerColor),
                    const SizedBox(height: 16),
                    Text(
                      'Looking for complete subsystem legal mappings?',
                      style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.assignment_turned_in_outlined, size: 18),
                      label: const Text('View All System Licenses', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // Native engine popup processing standard compilation licenses tree automatically
                        showLicensePage(
                          context: context,
                          applicationName: 'MARK',
                          applicationVersion: 'v1.0.0', // Set to your current build iteration text
                          applicationLegalese: '© 2026 MANOG Labs',
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            final package = dependencyLicenses[index - 1];
            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.dividerColor, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        package['name']!,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          package['type']!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package['desc']!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}