import 'package:flutter/material.dart';

class OpenSourceLicensesScreen extends StatelessWidget {
  const OpenSourceLicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final Color bgColor = theme.scaffoldBackgroundColor;

    // A map of major standard packages
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
      backgroundColor: bgColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: bgColor,
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
      body: Stack(
        children: [
          // Layer 1: Scrollable List
          SafeArea(
            bottom: false,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              // Added 120px bottom padding so the last item scrolls past the gradient
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 120.0),
              itemCount: dependencyLicenses.length + 1, // Only header (1) + dependencies count
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

          // Layer 2: Telegram-Style Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120, // Height of the fade
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0),
                      bgColor.withOpacity(0.8),
                      bgColor,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}