import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/text_fields.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          children: [
            // Profile picture
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.softGradient,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 60,
                    color: AppColors.royalPurple,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleGradient,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingL),

            // Name and verification status
            Text('Sarah Mitchell', style: AppTextStyles.headlineLarge),
            const SizedBox(height: AppConstants.spacingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.verified_user_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  'Verified Member',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingXL),

            // Stats cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.directions_car_rounded,
                    value: '47',
                    label: 'Trips',
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.star_rounded,
                    value: '4.9',
                    label: 'Rating',
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.favorite_rounded,
                    value: '12',
                    label: 'Favorites',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingXL),

            // Menu items
            _buildMenuItem(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.payment_rounded,
              title: 'Payment Methods',
              onTap: () {
                Navigator.of(context).pushNamed('/payments');
              },
            ),
            _buildMenuItem(
              icon: Icons.people_outline_rounded,
              title: 'Trusted Contacts',
              onTap: () {
                Navigator.of(context).pushNamed('/trusted-contacts');
              },
            ),
            _buildMenuItem(
              icon: Icons.history_rounded,
              title: 'Ride History',
              onTap: () {
                Navigator.of(context).pushNamed('/ride-history');
              },
            ),
            _buildMenuItem(
              icon: Icons.security_rounded,
              title: 'Safety Center',
              onTap: () {
                Navigator.of(context).pushNamed('/safety-center');
              },
            ),
            _buildMenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.info_outline_rounded,
              title: 'About GirlRide',
              onTap: () {},
            ),
            const SizedBox(height: AppConstants.spacingL),

            // Logout button
            SecondaryButton(
              text: 'Log Out',
              icon: Icons.logout_rounded,
              onPressed: () {},
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppColors.paleLavender,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.royalPurple,
            size: AppConstants.iconSizeL,
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            value,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.royalPurple,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              decoration: BoxDecoration(
                color: AppColors.paleLavender,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: Icon(
                icon,
                color: AppColors.royalPurple,
                size: AppConstants.iconSizeM,
              ),
            ),
            const SizedBox(width: AppConstants.spacingM),
            Expanded(child: Text(title, style: AppTextStyles.bodyLarge)),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.greyMedium,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
