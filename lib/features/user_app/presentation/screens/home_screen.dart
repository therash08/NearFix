import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSearchBar(),
              const SizedBox(height: 32),
              _buildCategoryGrid(),
              const SizedBox(height: 32),
              _buildNearbyProviders(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find services near you',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(
                    LucideIcons.mapPin,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Gulshan 2, Dhaka',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(LucideIcons.bell, size: 24),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.search, color: AppTheme.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Try: "Electrician near me"',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryCyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.slidersHorizontal,
              color: AppTheme.primaryCyan,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = [
      {
        'icon': LucideIcons.wind,
        'name': 'AC Repair Services',
        'colors': [Color(0xFFBDE7FF), Color(0xFFCDE8FF)],
      },
      {
        'icon': LucideIcons.monitor,
        'name': 'Appliance Repair',
        'colors': [Color(0xFFFFE7D1), Color(0xFFFFF0E6)],
      },
      {
        'icon': LucideIcons.sprayCan,
        'name': 'Cleaning Solution',
        'colors': [Color(0xFFD9FCFF), Color(0xFFE8F8FF)],
      },
      {
        'icon': LucideIcons.scissors,
        'name': 'Beauty & Wellness',
        'colors': [Color(0xFFF3E8FF), Color(0xFFE5F0FF)],
      },
      {
        'icon': LucideIcons.truck,
        'name': 'Shifting Services',
        'colors': [Color(0xFFDDEBFF), Color(0xFFEFF6FF)],
      },
      {
        'icon': LucideIcons.shoppingBag,
        'name': 'Sheba Shop',
        'colors': [Color(0xFFDFFCF3), Color(0xFFEFFDF8)],
      },
      {
        'icon': LucideIcons.scissors,
        'name': 'Men’s Care & Salon',
        'colors': [Color(0xFFFCE8FF), Color(0xFFF7F0FF)],
      },
      {
        'icon': LucideIcons.heart,
        'name': 'Health & Care',
        'colors': [Color(0xFFFFF0F3), Color(0xFFFFF8FA)],
      },
      {
        'icon': LucideIcons.monitor,
        'name': 'Electronics & Gadgets',
        'colors': [Color(0xFFE6F2FF), Color(0xFFEFF9FF)],
      },
      {
        'icon': LucideIcons.zap,
        'name': 'Electric & Plumbing',
        'colors': [Color(0xFFFFF7EA), Color(0xFFFFFDF2)],
      },
      {
        'icon': LucideIcons.bug,
        'name': 'Pest Control',
        'colors': [Color(0xFFEFFFE8), Color(0xFFF7FFF0)],
      },
      {
        'icon': LucideIcons.user,
        'name': 'Driver Service',
        'colors': [Color(0xFFEFF6FF), Color(0xFFF6FBFF)],
      },
      {
        'icon': LucideIcons.car,
        'name': 'Car Care Services',
        'colors': [Color(0xFFFFEFEF), Color(0xFFFFF6F6)],
      },
      {
        'icon': LucideIcons.mapPin,
        'name': 'Trips & Travels',
        'colors': [Color(0xFFEFF7FF), Color(0xFFF7FBFF)],
      },
      {
        'icon': LucideIcons.car,
        'name': 'Car Rental',
        'colors': [Color(0xFFE6FFF6), Color(0xFFF2FFF9)],
      },
      {
        'icon': Icons.format_paint,
        'name': 'Painting & Renovation',
        'colors': [Color(0xFFFFEFFF), Color(0xFFFFF5FF)],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See All',
                style: TextStyle(color: AppTheme.primaryBlue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxis = width > 600 ? 6 : 4;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxis,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final colors =
                    (cat['colors'] as List<Color>?) ??
                    [AppTheme.primaryBlue, AppTheme.primaryCyan];
                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: colors,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            cat['icon'] as IconData,
                            size: 28,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          cat['name'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildNearbyProviders() {
    final providers = [
      {
        'name': 'Rahul Sharma',
        'service': 'Expert Electrician',
        'rating': '4.9',
        'distance': '1.2 km',
        'status': 'Available Now',
      },
      {
        'name': 'Kamal Hasan',
        'service': 'AC Repair Specialist',
        'rating': '4.7',
        'distance': '2.5 km',
        'status': 'Available Now',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nearby Providers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: providers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final p = providers[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          LucideIcons.user,
                          color: AppTheme.primaryPurple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p['service']!,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  p['rating']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  LucideIcons.mapPin,
                                  color: AppTheme.textSecondary,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  p['distance']!,
                                  style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Available',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.phone, size: 18),
                          label: const Text('Call'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryBlue,
                            side: const BorderSide(color: AppTheme.primaryBlue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Book Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
