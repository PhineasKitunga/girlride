import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/text_fields.dart';
import '../../../shared/widgets/cards.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({Key? key}) : super(key: key);

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final _pickupController = TextEditingController();
  final _destinationController = TextEditingController();
  String _selectedRideType = 'standard';

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _requestRide() {
    Navigator.of(context).pushNamed('/matching');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Request Ride'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location inputs
              CustomTextField(
                label: 'Pickup Location',
                hint: 'Enter pickup location',
                controller: _pickupController,
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.royalPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                readOnly: true,
                onTap: () {
                  // Open location picker
                },
              ),
              const SizedBox(height: AppConstants.spacingM),

              CustomTextField(
                label: 'Destination',
                hint: 'Where are you going?',
                controller: _destinationController,
                prefixIcon: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.error,
                ),
                readOnly: true,
                onTap: () {
                  // Open location picker
                },
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Ride type selection
              Text('Select Ride Type', style: AppTextStyles.headlineSmall),
              const SizedBox(height: AppConstants.spacingM),

              _RideTypeCard(
                icon: Icons.directions_car_rounded,
                title: 'Standard Ride',
                description: 'Affordable rides for everyday use',
                price: '\$12.50',
                eta: '5 min',
                value: 'standard',
                groupValue: _selectedRideType,
                onChanged: (value) {
                  setState(() => _selectedRideType = value!);
                },
              ),
              const SizedBox(height: AppConstants.spacingM),

              _RideTypeCard(
                icon: Icons.nightlight_rounded,
                title: 'Night-Safe Ride',
                description: 'Extra verified driver for night trips',
                price: '\$15.00',
                eta: '7 min',
                value: 'night-safe',
                groupValue: _selectedRideType,
                onChanged: (value) {
                  setState(() => _selectedRideType = value!);
                },
              ),
              const SizedBox(height: AppConstants.spacingM),

              _RideTypeCard(
                icon: Icons.schedule_rounded,
                title: 'Scheduled Ride',
                description: 'Book your ride in advance',
                price: '\$13.00',
                eta: 'Later',
                value: 'scheduled',
                groupValue: _selectedRideType,
                onChanged: (value) {
                  setState(() => _selectedRideType = value!);
                },
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Fare estimate
              SoftCard(
                color: AppColors.paleLavender,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Fare', style: AppTextStyles.bodyMedium),
                        Text(
                          '\$12.50 - \$15.00',
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.royalPurple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Distance', style: AppTextStyles.bodySmall),
                        Text('4.2 km', style: AppTextStyles.bodySmall),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duration', style: AppTextStyles.bodySmall),
                        Text('12-15 min', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Request button
              PrimaryButton(
                text: 'Request Ride',
                onPressed: _requestRide,
                width: double.infinity,
                gradient: true,
                icon: Icons.arrow_forward_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String price;
  final String eta;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _RideTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
    required this.eta,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.paleLavender : AppColors.greyLight,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(
            color: isSelected ? AppColors.royalPurple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.royalPurple : AppColors.greyDark,
                size: AppConstants.iconSizeL,
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
                      color: isSelected
                          ? AppColors.royalPurple
                          : AppColors.darkCharcoal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.greyDark,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isSelected
                        ? AppColors.royalPurple
                        : AppColors.darkCharcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    eta,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
