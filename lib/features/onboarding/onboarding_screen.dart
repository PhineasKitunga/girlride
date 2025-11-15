import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.woman_rounded,
      title: 'Women-Only Environment',
      description:
          'A safe, supportive community exclusively for women. Every rider and driver is verified to ensure your comfort and security.',
      color: AppColors.royalPurple,
    ),
    OnboardingPage(
      icon: Icons.verified_user_rounded,
      title: 'Verified Female Drivers',
      description:
          'All our drivers go through rigorous background checks, identity verification, and safety training to ensure your peace of mind.',
      color: AppColors.lavender,
    ),
    OnboardingPage(
      icon: Icons.gps_fixed_rounded,
      title: 'Real-Time Safety Tools',
      description:
          'Live ride tracking, route monitoring, and instant alerts keep you and your loved ones informed throughout your journey.',
      color: AppColors.mediumPurple,
    ),
    OnboardingPage(
      icon: Icons.emergency_rounded,
      title: 'Panic Button Feature',
      description:
          'Immediate access to emergency services and your trusted contacts with just one tap. Help is always at your fingertips.',
      color: AppColors.panicRed,
    ),
    OnboardingPage(
      icon: Icons.people_rounded,
      title: 'Community & Trust',
      description:
          'Join a community built on trust, respect, and empowerment. Rate your experience and help us maintain the highest standards.',
      color: AppColors.deepViolet,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: AppConstants.animationMedium,
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }

  void _skipOnboarding() {
    Navigator.of(context).pushReplacementNamed('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingM),
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: Text(
                    'Skip',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.greyDark,
                    ),
                  ),
                ),
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _OnboardingPageWidget(page: _pages[index]);
                },
              ),
            ),
            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _PageIndicator(isActive: index == _currentPage),
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),
            // Navigation button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingXL,
              ),
              child: PrimaryButton(
                text: _currentPage == _pages.length - 1
                    ? 'Get Started'
                    : 'Next',
                onPressed: _nextPage,
                width: double.infinity,
                gradient: true,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const _OnboardingPageWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with gradient background
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  page.color.withOpacity(0.2),
                  page.color.withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: page.color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(page.icon, size: 60, color: page.color),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingXXL),
          // Title
          Text(
            page.title,
            style: AppTextStyles.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingL),
          // Description
          Text(
            page.description,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.greyDark,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.animationMedium,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.royalPurple : AppColors.lavender,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
