import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
                      color: colorScheme.surfaceContainerHighest.withOpacity(
                        0.4,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Application: MarkBus',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Developer: MANOG Labs',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Divider(color: theme.dividerColor, height: 1),
                        const SizedBox(height: 12),
                        Text(
                          'Effective Date: July 2026',
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
                    'Welcome to MARK, developed by MANOG Labs.\n\nAt MANOG Labs, we respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how MARK collects, uses, stores, and protects information when you use the application.\n\nBy using MARK, you agree to the practices described in this Privacy Policy.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle(context, 'About MARK'),
                  _buildSectionBody(
                    context,
                    'MARK is an intelligent public transportation journey planner designed to help users discover efficient bus routes, view trip details, and plan journeys using offline transit data.\n\nThe application is intended to simplify public transportation while providing a smooth and reliable user experience.',
                  ),

                  _buildSectionTitle(context, 'Information We Collect'),
                  _buildSectionBody(
                    context,
                    'MARK collects only the information necessary for the proper functioning of the application. The application may collect:',
                  ),
                  _buildBulletItem(context, 'Device model'),
                  _buildBulletItem(context, 'Android version'),
                  _buildBulletItem(context, 'Application version'),
                  _buildBulletItem(
                    context,
                    'Crash reports (if enabled in future)',
                  ),
                  _buildBulletItem(
                    context,
                    'Anonymous diagnostic information (if enabled)',
                  ),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'MARK does not intentionally collect personal information such as:',
                  ),
                  _buildBulletItem(context, 'Name'),
                  _buildBulletItem(context, 'Phone Number'),
                  _buildBulletItem(context, 'Email Address'),
                  _buildBulletItem(context, 'Government Identification'),
                  _buildBulletItem(context, 'Bank Information'),
                  _buildBulletItem(context, 'Payment Information'),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'unless voluntarily provided by you while contacting support.',
                  ),

                  _buildSectionTitle(context, 'Location Permission'),
                  _buildSectionBody(
                    context,
                    'MARK may request access to your device\'s location. Location information is used only for:',
                  ),
                  _buildBulletItem(context, 'Finding nearby bus stops'),
                  _buildBulletItem(context, 'Displaying your current location'),
                  _buildBulletItem(
                    context,
                    'Planning journeys from your current position',
                  ),
                  _buildBulletItem(context, 'Improving navigation experience'),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'Your location is never sold or shared for advertising purposes.\n\nYou may disable location permission at any time from your device settings. Some features may not function correctly without location access.',
                  ),

                  _buildSectionTitle(context, 'Internet Usage'),
                  _buildSectionBody(
                    context,
                    'MARK works primarily offline. Internet access may be used only for:',
                  ),
                  _buildBulletItem(context, 'Checking for database updates'),
                  _buildBulletItem(
                    context,
                    'Downloading updated transit information',
                  ),
                  _buildBulletItem(context, 'Bug reporting (future versions)'),
                  _buildBulletItem(
                    context,
                    'AI Assistant features (future versions)',
                  ),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'Internet access is never used to collect unnecessary personal information.',
                  ),

                  _buildSectionTitle(context, 'Offline Transit Database'),
                  _buildSectionBody(
                    context,
                    'MARK contains an offline transit database used for journey planning. The transit information stored inside the application does not contain personal user information.\n\nTransit schedules may change over time. Although every effort is made to maintain accurate information, schedule accuracy cannot be guaranteed.',
                  ),

                  _buildSectionTitle(context, 'Notifications'),
                  _buildSectionBody(
                    context,
                    'If notification permission is granted, MARK may send notifications regarding:',
                  ),
                  _buildBulletItem(context, 'Journey reminders'),
                  _buildBulletItem(context, 'Scheduled trips'),
                  _buildBulletItem(context, 'Database updates'),
                  _buildBulletItem(context, 'Important application updates'),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'Users can disable notifications at any time from device settings.',
                  ),

                  _buildSectionTitle(context, 'Data Storage'),
                  _buildSectionBody(
                    context,
                    'Most application data is stored locally on your device. This may include:',
                  ),
                  _buildBulletItem(context, 'Saved preferences'),
                  _buildBulletItem(context, 'Favorite stops'),
                  _buildBulletItem(context, 'Recent searches'),
                  _buildBulletItem(context, 'Planned trips'),
                  _buildBulletItem(context, 'Downloaded transit database'),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'This information remains on your device unless removed by you.',
                  ),

                  _buildSectionTitle(context, 'Third-Party Services'),
                  _buildSectionBody(
                    context,
                    'MARK may use third-party services to improve functionality. These services may include:',
                  ),
                  _buildBulletItem(context, 'Google Play Services'),
                  _buildBulletItem(context, 'Firebase (future)'),
                  _buildBulletItem(context, 'Google Maps (future)'),
                  _buildBulletItem(
                    context,
                    'Official transit data providers (future)',
                  ),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'Each third-party service has its own Privacy Policy. MANOG Labs is not responsible for the privacy practices of third-party services.',
                  ),

                  _buildSectionTitle(context, 'Data Security'),
                  _buildSectionBody(
                    context,
                    'We implement reasonable technical and organizational measures to protect your information. While we strive to protect your information, no method of electronic storage or internet transmission is completely secure. Therefore, absolute security cannot be guaranteed.',
                  ),

                  _buildSectionTitle(context, 'Data Sharing'),
                  _buildSectionBody(
                    context,
                    'MANOG Labs does not sell, rent, or trade your personal information. Information may only be shared:',
                  ),
                  _buildBulletItem(context, 'When required by applicable law'),
                  _buildBulletItem(context, 'To comply with legal obligations'),
                  _buildBulletItem(
                    context,
                    'To protect the rights and safety of users',
                  ),
                  _buildBulletItem(context, 'With your explicit consent'),

                  _buildSectionTitle(context, 'User Rights'),
                  _buildSectionBody(
                    context,
                    'Depending on your jurisdiction, you may have the right to:',
                  ),
                  _buildBulletItem(context, 'Access your information'),
                  _buildBulletItem(context, 'Correct inaccurate information'),
                  _buildBulletItem(
                    context,
                    'Delete locally stored information',
                  ),
                  _buildBulletItem(context, 'Withdraw permissions'),
                  _buildBulletItem(
                    context,
                    'Stop using the application at any time',
                  ),

                  _buildSectionTitle(context, 'Children\'s Privacy'),
                  _buildSectionBody(
                    context,
                    'MARK is not specifically intended for children under the age of 13. We do not knowingly collect personal information from children. If you believe a child has provided personal information, please contact us so appropriate action can be taken.',
                  ),

                  _buildSectionTitle(context, 'Transit Information Disclaimer'),
                  _buildSectionBody(
                    context,
                    'MARK provides journey planning assistance using available transit information. Transit schedules, routes, arrival times, and departure times are subject to change without notice.\n\nUsers are encouraged to verify important travel information whenever possible.\n\nMANOG Labs is not responsible for losses resulting from schedule changes, delays, cancellations, or operational decisions made by transport operators.',
                  ),

                  _buildSectionTitle(context, 'Future Features'),
                  _buildSectionBody(
                    context,
                    'Future versions of MARK may introduce:',
                  ),
                  _buildBulletItem(context, 'Live transit tracking'),
                  _buildBulletItem(context, 'Official GTFS integration'),
                  _buildBulletItem(context, 'Cloud synchronization'),
                  _buildBulletItem(context, 'AI-powered travel assistant'),
                  _buildBulletItem(context, 'User accounts'),
                  const SizedBox(height: 12),
                  _buildSectionBody(
                    context,
                    'Whenever significant privacy-related features are introduced, this Privacy Policy will be updated accordingly.',
                  ),

                  _buildSectionTitle(context, 'Changes to This Privacy Policy'),
                  _buildSectionBody(
                    context,
                    'MANOG Labs reserves the right to modify this Privacy Policy at any time. Changes become effective immediately after publication inside the application. Users are encouraged to review this Privacy Policy periodically.',
                  ),

                  _buildSectionTitle(context, 'Contact Us'),
                  _buildSectionBody(
                    context,
                    'If you have questions, suggestions, or concerns regarding this Privacy Policy, please contact:',
                  ),
                  const SizedBox(height: 12),

                  // Contact Detail Blocks
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(
                        0.3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.dividerColor, width: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        children: [
                          Material(
                            child: ListTile(
                              leading: Icon(
                                Icons.business,
                                color: colorScheme.primary,
                              ),
                              title: Text(
                                'MANOG Labs',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Divider(height: 1, color: theme.dividerColor,),
                          Material(
                            child: ListTile(
                              leading: Icon(
                                Icons.email_outlined,
                                color: colorScheme.primary,
                              ),
                              title: Text('contact.manoglabs@gmail.com'),
                              subtitle: Text('Tap to copy support email'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Separator & Copyright Footer Block
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
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'MARK and its associated logos, interface designs, and software are the intellectual property of MANOG Labs unless otherwise stated.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withOpacity(
                                0.7,
                              ),
                              fontSize: 11,
                              height: 1.4,
                            ),
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

  // Section Header Generator Utility
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

  // Section Body Generator Utility
  Widget _buildSectionBody(BuildContext context, String bodyText) {
    return Text(
      bodyText,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        height: 1.5,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
      ),
    );
  }

  // Clean Bullet Point Layout Builder Utility
  Widget _buildBulletItem(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 6.0, right: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 8.0),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.4,
                color: colorScheme.onSurface.withOpacity(0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
