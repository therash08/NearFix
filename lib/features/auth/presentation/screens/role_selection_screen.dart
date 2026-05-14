import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: AppTheme.softGradientBackground,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _roleCard(
                          context,
                          leadIcon: Icons.person,
                          title: 'User / Customer',
                          subtitle: 'Find and book local professionals',
                          features: const [
                            'Search services',
                            'Nearby providers',
                            'Booking',
                            'Reviews',
                            'Favorites',
                            'Chat & Call',
                          ],
                          buttonText: 'I Need Service',
                          onTap: () => context.go('/login-user'),
                        ),
                        const SizedBox(height: 16),
                        _roleCard(
                          context,
                          leadIcon: Icons.construction,
                          title: 'Service Provider',
                          subtitle: 'Join and earn by offering services',
                          features: const [
                            'Add service',
                            'Profile management',
                            'Accept bookings',
                            'Availability update',
                            'Earnings dashboard',
                            'Ratings',
                          ],
                          buttonText: 'I Provide Service',
                          onTap: () => context.go('/login-provider'),
                        ),
                        const SizedBox(height: 16),
                        _roleCard(
                          context,
                          leadIcon: Icons.admin_panel_settings,
                          title: 'Admin Panel',
                          subtitle: 'Manage platform operations',
                          features: const [
                            'Manage users',
                            'Verify providers',
                            'Remove fake accounts',
                            'Monitor bookings',
                            'Reports management',
                            'Category management',
                          ],
                          buttonText: 'Admin Login',
                          onTap: () => context.go('/admin-login'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(Icons.handyman, size: 28, color: AppTheme.primaryBlue),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'NearFix',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Welcome to NearFix',
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Choose how you want to use the app',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
        ),
      ],
    );
  }

  Widget _roleCard(
    BuildContext context, {
    required IconData leadIcon,
    required String title,
    required String subtitle,
    required List<String> features,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.primaryPurple.withOpacity(0.08),
                  ),
                  child: Icon(leadIcon, size: 28, color: AppTheme.primaryBlue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: features
                  .map(
                    (f) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: AppTheme.primaryCyan,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          f,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
