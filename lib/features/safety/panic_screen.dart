import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';

class PanicScreen extends StatefulWidget {
  const PanicScreen({Key? key}) : super(key: key);

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen>
    with SingleTickerProviderStateMixin {
  int _countdown = 5;
  bool _emergencyActivated = false;
  late Timer _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _startCountdown();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        _activateEmergency();
        timer.cancel();
      }
    });
  }

  void _activateEmergency() {
    setState(() => _emergencyActivated = true);
    // TODO: Implement emergency alert logic
  }

  void _cancelEmergency() {
    _timer.cancel();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _emergencyActivated
          ? AppColors.panicRed
          : AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingXL),
          child: _emergencyActivated
              ? _buildEmergencyActivatedView()
              : _buildCountdownView(),
        ),
      ),
    );
  }

  Widget _buildCountdownView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Warning icon
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_pulseController.value * 0.1),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.panicRed.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  size: 80,
                  color: AppColors.panicRed,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppConstants.spacingXXL),

        // Countdown
        Text(
          '$_countdown',
          style: AppTextStyles.displayLarge.copyWith(
            fontSize: 72,
            color: AppColors.panicRed,
          ),
        ),
        const SizedBox(height: AppConstants.spacingM),

        Text(
          'Emergency Alert Activating',
          style: AppTextStyles.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingM),

        Text(
          'Your emergency contacts and safety team will be notified',
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.greyDark),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingXXL * 2),

        // Cancel button
        PrimaryButton(
          text: 'Cancel Emergency',
          onPressed: _cancelEmergency,
          width: double.infinity,
          gradient: true,
        ),
      ],
    );
  }

  Widget _buildEmergencyActivatedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Emergency icon
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.crisis_alert_rounded,
            size: 80,
            color: AppColors.panicRed,
          ),
        ),
        const SizedBox(height: AppConstants.spacingXXL),

        Text(
          'EMERGENCY ALERT\nACTIVATED',
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingL),

        Container(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
          ),
          child: Column(
            children: [
              _buildAlertItem(
                icon: Icons.people_rounded,
                text: 'Emergency contacts notified',
                isCompleted: true,
              ),
              const SizedBox(height: AppConstants.spacingM),
              _buildAlertItem(
                icon: Icons.location_on_rounded,
                text: 'Live location sharing active',
                isCompleted: true,
              ),
              const SizedBox(height: AppConstants.spacingM),
              _buildAlertItem(
                icon: Icons.support_agent_rounded,
                text: 'Safety team alerted',
                isCompleted: true,
              ),
              const SizedBox(height: AppConstants.spacingM),
              _buildAlertItem(
                icon: Icons.mic_rounded,
                text: 'Audio recording started',
                isCompleted: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingXXL),

        // Call emergency button
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Call emergency services
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.panicRed,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingXL,
                vertical: AppConstants.spacingL,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone_rounded, size: 24),
                const SizedBox(width: AppConstants.spacingM),
                Text(
                  'Call Emergency Services',
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.panicRed,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingM),

        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'False Alarm - Deactivate',
            style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAlertItem({
    required IconData icon,
    required String text,
    required bool isCompleted,
  }) {
    return Row(
      children: [
        Icon(
          isCompleted
              ? Icons.check_circle_rounded
              : Icons.hourglass_empty_rounded,
          color: AppColors.white,
          size: 24,
        ),
        const SizedBox(width: AppConstants.spacingM),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
