import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({Key? key}) : super(key: key);

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Map view
          Container(
            color: AppColors.paleLavender,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_rounded, size: 100, color: AppColors.lavender),
                  SizedBox(height: AppConstants.spacingM),
                  Text(
                    'Live GPS Tracking',
                    style: TextStyle(fontSize: 18, color: AppColors.greyDark),
                  ),
                ],
              ),
            ),
          ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(AppConstants.spacingM),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingL,
                  vertical: AppConstants.spacingM,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lavender.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arriving in 8 minutes',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.royalPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('3.5 km away', style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.share_rounded,
                        color: AppColors.royalPurple,
                      ),
                      onPressed: () {
                        // Share trip
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Panic button
          Positioned(
            right: AppConstants.spacingL,
            top: MediaQuery.of(context).size.height * 0.4,
            child: PanicButton(
              onPanic: () {
                Navigator.of(context).pushNamed('/panic');
              },
              isCompact: true,
            ),
          ),

          // Driver info bottom sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.radiusXL),
                  topRight: Radius.circular(AppConstants.radiusXL),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lavender.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress indicator
                    Row(
                      children: [
                        _buildProgressStep(
                          icon: Icons.my_location_rounded,
                          label: 'Pickup',
                          isActive: true,
                          isCompleted: false,
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: AppColors.lavender,
                          ),
                        ),
                        _buildProgressStep(
                          icon: Icons.directions_car_rounded,
                          label: 'En Route',
                          isActive: true,
                          isCompleted: false,
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: AppColors.lavender,
                          ),
                        ),
                        _buildProgressStep(
                          icon: Icons.location_on_rounded,
                          label: 'Dropoff',
                          isActive: false,
                          isCompleted: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingL),
                    const Divider(),
                    const SizedBox(height: AppConstants.spacingM),

                    // Driver info
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.paleLavender,
                          child: Icon(
                            Icons.person_rounded,
                            size: 28,
                            color: AppColors.royalPurple,
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacingM),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sarah Johnson',
                                style: AppTextStyles.labelLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Toyota Camry • ABC 1234',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.greyDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.phone_rounded),
                              color: AppColors.royalPurple,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.message_rounded),
                              color: AppColors.royalPurple,
                              onPressed: () {
                                Navigator.of(context).pushNamed('/chat');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive || isCompleted
                ? AppColors.royalPurple
                : AppColors.lavender,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check_rounded : icon,
            color: AppColors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isActive || isCompleted
                ? AppColors.royalPurple
                : AppColors.greyMedium,
          ),
        ),
      ],
    );
  }
}
