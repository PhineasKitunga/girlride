import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/cards.dart';

class SafetyCenterScreen extends StatelessWidget {
  const SafetyCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Safety Center'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Your Safety\nIs Our Priority',
              style: AppTextStyles.displayMedium.copyWith(
                color: AppColors.royalPurple,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),

            // Emergency features
            Text('Emergency Features', style: AppTextStyles.headlineSmall),
            const SizedBox(height: AppConstants.spacingM),

            FeatureCard(
              icon: Icons.crisis_alert_rounded,
              title: 'Panic Button',
              description:
                  'Instant access to emergency services and your trusted contacts. Help arrives at your fingertips.',
            ),
            const SizedBox(height: AppConstants.spacingM),

            FeatureCard(
              icon: Icons.people_rounded,
              title: 'Trusted Contacts',
              description:
                  'Share your ride details and location with friends and family automatically.',
            ),
            const SizedBox(height: AppConstants.spacingM),

            FeatureCard(
              icon: Icons.location_on_rounded,
              title: 'Live Location Sharing',
              description:
                  'Real-time location tracking keeps your loved ones informed throughout your journey.',
            ),
            const SizedBox(height: AppConstants.spacingXL),

            // Safety tips
            Text('Safety Guidelines', style: AppTextStyles.headlineSmall),
            const SizedBox(height: AppConstants.spacingM),

            _buildSafetyTip(
              number: '1',
              title: 'Verify Your Driver',
              description:
                  'Always check the driver\'s photo, name, and car details before getting in.',
            ),
            const SizedBox(height: AppConstants.spacingM),

            _buildSafetyTip(
              number: '2',
              title: 'Share Your Trip',
              description:
                  'Let trusted contacts know when you\'re traveling, especially at night.',
            ),
            const SizedBox(height: AppConstants.spacingM),

            _buildSafetyTip(
              number: '3',
              title: 'Trust Your Instincts',
              description:
                  'If something feels wrong, don\'t hesitate to use the panic button or end the ride.',
            ),
            const SizedBox(height: AppConstants.spacingM),

            _buildSafetyTip(
              number: '4',
              title: 'Sit in the Back',
              description:
                  'For your safety, always choose the back seat during your ride.',
            ),
            const SizedBox(height: AppConstants.spacingM),

            _buildSafetyTip(
              number: '5',
              title: 'Stay Connected',
              description:
                  'Keep your phone charged and accessible throughout your journey.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyTip({
    required String number,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        color: AppColors.paleLavender,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: AppColors.purpleGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.royalPurple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
