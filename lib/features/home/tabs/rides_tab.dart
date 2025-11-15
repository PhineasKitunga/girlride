import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/cards.dart';

class RidesTab extends StatefulWidget {
  const RidesTab({Key? key}) : super(key: key);

  @override
  State<RidesTab> createState() => _RidesTabState();
}

class _RidesTabState extends State<RidesTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _userId = '';
  List<Map<String, dynamic>> _cachedRides = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRides();
  }

  Future<void> _loadRides() async {
    // Get user ID from cache
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('user_uid');
    
    if (uid == null) {
      setState(() => _isLoading = false);
      return;
    }

    setState(() {
      _userId = uid;
      _isLoading = true;
    });

    try {
      // Try to load from cache first
      final cachedData = prefs.getString('rides_cache');
      if (cachedData != null) {
        setState(() {
          _cachedRides = [];
          _isLoading = false;
        });
      }

      // Fetch from Firestore
      final ridesSnapshot = await FirebaseFirestore.instance
          .collection('rides')
          .where('riderId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .limit(20)
          .get();

      if (mounted) {
        final ridesList = ridesSnapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();

        setState(() {
          _cachedRides = ridesList;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('My Rides', style: AppTextStyles.headlineLarge),
        elevation: 0,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.royalPurple),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _cachedRides.isEmpty
              ? _buildEmptyState()
              : _buildRidesList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/ride-request');
        },
        backgroundColor: AppColors.royalPurple,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Book Ride'),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.royalPurple),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_car_rounded,
              size: 120,
              color: AppColors.lavender.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.spacingXL),
            Text(
              'No rides yet',
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              'Book your first ride and enjoy a safe journey with GirlRide',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.greyDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRidesList() {
    return RefreshIndicator(
      onRefresh: _loadRides,
      color: AppColors.royalPurple,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        itemCount: _cachedRides.length,
        itemBuilder: (context, index) {
          final ride = _cachedRides[index];
          return _RideCard(ride: ride);
        },
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXL),
          ),
        ),
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter Rides', style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppConstants.spacingL),
            _FilterOption(
              icon: Icons.check_circle_rounded,
              title: 'Completed',
              onTap: () => Navigator.pop(context),
            ),
            _FilterOption(
              icon: Icons.cancel_rounded,
              title: 'Cancelled',
              onTap: () => Navigator.pop(context),
            ),
            _FilterOption(
              icon: Icons.schedule_rounded,
              title: 'Upcoming',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  final Map<String, dynamic> ride;

  const _RideCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: AppColors.greyLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppConstants.spacingS),
                      decoration: BoxDecoration(
                        color: AppColors.paleLavender,
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      ),
                      child: const Icon(
                        Icons.directions_car_rounded,
                        color: AppColors.royalPurple,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride['destination'] ?? 'Unknown Destination',
                            style: AppTextStyles.headlineSmall,
                          ),
                          Text(
                            ride['date'] ?? 'No date',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.greyDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusBadge(status: ride['status'] ?? 'completed'),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingM),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: AppColors.greyDark),
                    const SizedBox(width: AppConstants.spacingXS),
                    Expanded(
                      child: Text(
                        ride['pickup'] ?? 'No pickup location',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.greyDark,
                        ),
                      ),
                    ),
                    Text(
                      '\$${ride['fare'] ?? '0.00'}',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.royalPurple,
                      ),
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

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status.toLowerCase()) {
      case 'completed':
        color = AppColors.success;
        text = 'Completed';
        break;
      case 'cancelled':
        color = AppColors.error;
        text = 'Cancelled';
        break;
      case 'ongoing':
        color = AppColors.royalPurple;
        text = 'Ongoing';
        break;
      default:
        color = AppColors.greyDark;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingXS,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(color: color),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _FilterOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.royalPurple),
      title: Text(title, style: AppTextStyles.bodyLarge),
      onTap: onTap,
    );
  }
}
