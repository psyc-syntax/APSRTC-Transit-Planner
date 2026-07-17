import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final Color bgColor = theme.scaffoldBackgroundColor;

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
          'Terms & Conditions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Layer 1: Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              // Added generous 120px bottom padding to clear the gradient when fully scrolled
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 120.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agreement Terms for MARK',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Issued by: MANOG Labs',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Divider(color: theme.dividerColor, height: 1),
                        const SizedBox(height: 12),
                        Text(
                          'Last Updated: July 2026',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Introduction
                  Text(
                    'Please read these Terms and Conditions carefully before using the MARK mobile application operated by MANOG Labs.\n\nYour access to and use of the application is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users, and others who access or use the application.',
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: colorScheme.onSurface),
                  ),

                  _buildSectionTitle(context, '1. Acceptable Use'),
                  _buildSectionBody(context, 
                    'By using MARK, you warrant that you will not use this application for any purpose that is unlawful, prohibited by these terms, or intended to disrupt public transit systems or third-party networks.'
                  ),

                  // LEGAL PROTECTION / SHIELD FOR APSRTC DATA
                  _buildSectionTitle(context, '2. Public Transit Data & Source Disclaimer'),
                  _buildSectionBody(context, 
                    'MARK provides route planning assistance using public-facing scheduling layouts, stops, and informational structures sourced from the Andhra Pradesh State Road Transport Corporation (APSRTC) public endpoints.'
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.error.withOpacity(0.3), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.gavel_rounded, color: colorScheme.error, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Legal Firewalls & Status Notice:',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildShieldBullet(context, 'No Official Affiliation:', 'MARK is a completely independent informational utility developed privately by MANOG Labs. It is NOT affiliated with, authorized, sponsored, endorsed, or in any way officially connected to APSRTC or any government agency or transport corporation.'),
                        _buildShieldBullet(context, 'As-Is Data Warranty:', 'Data retrieved from public domains is parsed, processed, and cached to operate offline. MANOG Labs gives no warranty—express or implied—regarding the uninterrupted availability, continuous accuracy, structural updates, or completeness of transit timings, bus routes, or vehicle allocations.'),
                        _buildShieldBullet(context, 'Force Majeure & Timing Deviations:', 'Actual bus operations, platform shifts, delays, cancellations, and fare pricing adjustments are managed entirely at the discretion of APSRTC. MANOG Labs is not responsible for sudden data deviations from actual field settings.'),
                      ],
                    ),
                  ),

                  _buildSectionTitle(context, '3. Limitation of Liability'),
                  _buildSectionBody(context, 
                    'In no event shall MANOG Labs, nor its directors, employees, or partners, be liable for any indirect, incidental, special, consequential, or punitive damages—including without limitation, loss of time, missed connections, transport costs, emotional distress, or other intangible losses—resulting from your reliance on route coordinates, transit graphs, or predictive models displayed in the app.'
                  ),

                  _buildSectionTitle(context, '4. Intellectual Property'),
                  _buildSectionBody(context, 
                    'The core engine design, codebase compilers, trademarked icons, and visual UI layouts are the exclusive property of MANOG Labs. Any data points, brand names, and logistics markings belonging to APSRTC remain the proprietary intellectual property of the respective transit corporation.'
                  ),

                  _buildSectionTitle(context, '5. System Outages & Term Modifications'),
                  _buildSectionBody(context, 
                    'MANOG Labs reserves the right, at our sole discretion, to modify, sunset, or replace any system algorithm, package feature, or database timeline layout within the app at any time without prior written notification.'
                  ),

                  _buildSectionTitle(context, '6. Governing Law'),
                  _buildSectionBody(context, 
                    'These Terms shall be governed and construed in accordance with applicable localized consumer frameworks and information technology rules, without regard to conflict of law provisions.'
                  ),

                  // Bottom Section Footer Block
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2026 MANOG Labs. All Rights Reserved.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'By using MARK, you acknowledge you understand these liability bounds.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildSectionBody(BuildContext context, String bodyText) {
    return Text(
      bodyText,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
          ),
    );
  }

  Widget _buildShieldBullet(BuildContext context, String boldPrefix, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.4,
                  color: theme.colorScheme.onSurface.withOpacity(0.85),
                ),
                children: [
                  TextSpan(text: '$boldPrefix ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}