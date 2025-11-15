import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/cards.dart';

class DriverAssignedScreen extends StatelessWidget {
  const DriverAssignedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            _showCancelDialog(context);
          },
        ),
        title: const Text('Your Driver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              // Share trip
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.spacingL),
                child: Column(
                  children: [
                    // Driver info card
                    SoftCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Driver photo
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.paleLavender,
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 40,
                                      color: AppColors.royalPurple,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: AppColors.success,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.verified_rounded,
                                        color: AppColors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: AppConstants.spacingM),

                              // Driver details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Sarah Johnson',
                                          style: AppTextStyles.headlineSmall,
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.success
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                color: AppColors.warning,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '4.9',
                                                style: AppTextStyles.labelSmall
                                                    .copyWith(
                                                      color: AppColors
                                                          .darkCharcoal,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '1,234 rides • 3 years',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.greyDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spacingL),
                          const Divider(),
                          const SizedBox(height: AppConstants.spacingM),

                          // Car details
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(
                                  AppConstants.spacingM,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.paleLavender,
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusM,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.directions_car_rounded,
                                  color: AppColors.royalPurple,
                                  size: AppConstants.iconSizeL,
                                ),
                              ),
                              const SizedBox(width: AppConstants.spacingM),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Toyota Camry',
                                      style: AppTextStyles.labelLarge,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Silver • ABC 1234',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.greyDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingL),

                    // ETA card
                    SoftCard(
                      color: AppColors.paleLavender,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Driver arriving in',
                                style: AppTextStyles.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '3 minutes',
                                style: AppTextStyles.displaySmall.copyWith(
                                  color: AppColors.royalPurple,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(
                              AppConstants.spacingM,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                AppConstants.radiusM,
                              ),
                            ),
                            child: const Icon(
                              Icons.access_time_rounded,
                              color: AppColors.royalPurple,
                              size: AppConstants.iconSizeXL,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingL),

                    // Quick actions
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Call',
                            icon: Icons.phone_rounded,
                            onPressed: () {
                              // Call driver
                            },
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacingM),
                        Expanded(
                          child: SecondaryButton(
                            text: 'Message',
                            icon: Icons.message_rounded,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/chat');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom action button
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lavender.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: PrimaryButton(
                  text: 'Track Driver',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/tracking');
                  },
                  width: double.infinity,
                  gradient: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        ),
        title: Text('Cancel Ride?', style: AppTextStyles.headlineSmall),
        content: Text(
          'Are you sure you want to cancel this ride?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No, Keep Ride',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.greyDark,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}
