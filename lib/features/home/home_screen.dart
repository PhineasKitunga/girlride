import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/text_fields.dart';
import '../../../shared/widgets/cards.dart';
import '../../../shared/widgets/secure_google_map.dart';
import '../../../core/services/auth_service.dart';
import 'tabs/rides_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const RidesTab(),
    const _SafetyTab(),
    const _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.lavender.withOpacity(0.2),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.royalPurple,
          unselectedItemColor: AppColors.greyMedium,
          showUnselectedLabels: true,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_rounded),
              label: 'Rides',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security_rounded),
              label: 'Safety',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.paleLavender,
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.royalPurple,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Sarah!',
                          style: AppTextStyles.headlineSmall,
                        ),
                        Text(
                          'Where would you like to go?',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.greyDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_rounded,
                      color: AppColors.royalPurple,
                    ),
                  ),
                ],
              ),
            ),

            // Map view
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingL,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Secure Google Map (API key fetched from Firestore)
                    SecureGoogleMap(
                      initialPosition: const CameraPosition(
                        target: LatLng(-1.286389, 36.817223), // Nairobi, Kenya
                        zoom: 14.0,
                      ),
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                    ),

                    // Search bar overlay
                    Positioned(
                      top: AppConstants.spacingL,
                      left: AppConstants.spacingM,
                      right: AppConstants.spacingM,
                      child: SearchTextField(
                        hint: 'Where to?',
                        readOnly: true,
                        onTap: () {
                          Navigator.of(context).pushNamed('/ride-request');
                        },
                      ),
                    ),

                    // Panic button
                    Positioned(
                      right: AppConstants.spacingL,
                      bottom: AppConstants.spacingL,
                      child: PanicButton(
                        onPanic: () {
                          Navigator.of(context).pushNamed('/panic');
                        },
                        isCompact: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quick actions
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Actions', style: AppTextStyles.headlineSmall),
                  const SizedBox(height: AppConstants.spacingM),
                  Row(
                    children: [
                      Expanded(
                        child: QuickActionCard(
                          icon: Icons.security_rounded,
                          title: 'Safety Center',
                          onTap: () {
                            Navigator.of(context).pushNamed('/safety-center');
                          },
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Expanded(
                        child: QuickActionCard(
                          icon: Icons.people_rounded,
                          title: 'Trusted Contacts',
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed('/trusted-contacts');
                          },
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Expanded(
                        child: QuickActionCard(
                          icon: Icons.history_rounded,
                          title: 'Ride History',
                          onTap: () {
                            Navigator.of(context).pushNamed('/ride-history');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// RidesTab moved to separate file: tabs/rides_tab.dart

class _SafetyTab extends StatelessWidget {
  const _SafetyTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Safety Center', style: AppTextStyles.headlineLarge),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        children: [
          _SafetyCard(
            icon: Icons.emergency_rounded,
            title: 'Emergency SOS',
            subtitle: 'Quick access to emergency services',
            color: AppColors.error,
            onTap: () {
              Navigator.of(context).pushNamed('/panic');
            },
          ),
          _SafetyCard(
            icon: Icons.people_rounded,
            title: 'Trusted Contacts',
            subtitle: '2 contacts configured',
            color: AppColors.royalPurple,
            onTap: () {
              Navigator.of(context).pushNamed('/trusted-contacts');
            },
          ),
          _SafetyCard(
            icon: Icons.share_location_rounded,
            title: 'Live Location Sharing',
            subtitle: 'Share your ride with loved ones',
            color: AppColors.success,
            onTap: () {},
          ),
          _SafetyCard(
            icon: Icons.security_rounded,
            title: 'Safety Guidelines',
            subtitle: 'Learn about staying safe',
            color: AppColors.deepViolet,
            onTap: () {
              Navigator.of(context).pushNamed('/safety-center');
            },
          ),
        ],
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _SafetyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingM),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: Icon(icon, color: AppColors.white, size: 28),
                ),
                const SizedBox(width: AppConstants.spacingL),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.headlineSmall),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTab extends StatefulWidget {
  const _ProfileTab();

  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab> {
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';
  String _userPhone = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authService = AuthService();
    final cachedData = await authService.getCachedUserData();

    setState(() {
      _userName = cachedData['name'] ?? 'User';
      _userEmail = cachedData['email'] ?? 'email@example.com';
      _userPhone = cachedData['phone'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.headlineLarge),
        elevation: 0,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: AppColors.royalPurple),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        children: [
          // Profile header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.paleLavender,
                  child: Text(
                    _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
                    style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.royalPurple,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),
                Text(_userName, style: AppTextStyles.headlineMedium),
                Text(
                  _userEmail,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
                if (_userPhone.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    _userPhone,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.greyDark,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingXL),

          // Menu items
          _ProfileMenuItem(
            icon: Icons.person_rounded,
            title: 'Personal Information',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.payment_rounded,
            title: 'Payment Methods',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.history_rounded,
            title: 'Ride History',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.settings_rounded,
            title: 'Settings',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.help_rounded,
            title: 'Help & Support',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.logout_rounded,
            title: 'Sign Out',
            textColor: AppColors.error,
            onTap: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/welcome');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.royalPurple),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(color: textColor),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }
}
