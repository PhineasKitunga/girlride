import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.softGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingXL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                // Logo and branding
                Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: AppColors.purpleGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.royalPurple.withOpacity(0.3),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_taxi_rounded,
                        size: 70,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingXL),
                    Text(
                      'Welcome to ${AppConstants.appName}',
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.royalPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.spacingM),
                    Text(
                      AppConstants.appSlogan,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.greyDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const Spacer(),
                // Action buttons
                Column(
                  children: [
                    PrimaryButton(
                      text: 'Sign In',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      width: double.infinity,
                      gradient: true,
                    ),
                    const SizedBox(height: AppConstants.spacingM),
                    SecondaryButton(
                      text: 'Create Account',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      width: double.infinity,
                    ),
                    const SizedBox(height: AppConstants.spacingL),
                    Text(
                      'By continuing, you agree to our',
                      style: AppTextStyles.bodySmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Terms of Service',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.royalPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text('and', style: AppTextStyles.bodySmall),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Privacy Policy',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.royalPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
    );
  }
}
