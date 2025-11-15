import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({Key? key}) : super(key: key);

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  final List<String> _safetyTips = [
    'Always verify your driver\'s details before getting in',
    'Share your trip with trusted contacts',
    'Trust your instincts - if something feels wrong, use the panic button',
    'Check that the license plate matches the app',
    'Sit in the back seat for safety',
  ];

  int _currentTipIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Cycle through safety tips
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        setState(() {
          _currentTipIndex = (_currentTipIndex + 1) % _safetyTips.length;
        });
        return true;
      }
      return false;
    });

    // Navigate to driver assigned screen after matching
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/driver-assigned');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated matching indicator
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.purpleGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.royalPurple.withOpacity(0.3),
                        blurRadius: 32,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    size: 80,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingXXL),

              // Status text
              Text(
                'Finding a verified\nfemale driver...',
                style: AppTextStyles.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingM),

              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.royalPurple,
                ),
              ),
              const Spacer(),

              // Safety tip card
              AnimatedSwitcher(
                duration: AppConstants.animationMedium,
                child: Container(
                  key: ValueKey<int>(_currentTipIndex),
                  padding: const EdgeInsets.all(AppConstants.spacingL),
                  decoration: BoxDecoration(
                    color: AppColors.paleLavender,
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: AppColors.royalPurple,
                        size: AppConstants.iconSizeL,
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Safety Tip',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.royalPurple,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _safetyTips[_currentTipIndex],
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Cancel button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel Request',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
