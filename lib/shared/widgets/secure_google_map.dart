import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/services/maps_config_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Secure Google Maps widget that fetches API key from Firestore
class SecureGoogleMap extends StatefulWidget {
  final CameraPosition initialPosition;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final MapType mapType;
  final Set<Marker>? markers;
  final void Function(GoogleMapController)? onMapCreated;

  const SecureGoogleMap({
    Key? key,
    required this.initialPosition,
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = false,
    this.zoomControlsEnabled = false,
    this.compassEnabled = false,
    this.mapToolbarEnabled = false,
    this.mapType = MapType.normal,
    this.markers,
    this.onMapCreated,
  }) : super(key: key);

  @override
  State<SecureGoogleMap> createState() => _SecureGoogleMapState();
}

class _SecureGoogleMapState extends State<SecureGoogleMap> {
  final _mapsConfigService = MapsConfigService();
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  String? _apiKey;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  @override
  void dispose() {
    // Clean up to prevent memory leaks
    super.dispose();
  }

  Future<void> _loadApiKey() async {
    try {
      if (!mounted) return;
      
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      final apiKey = await _mapsConfigService.getApiKey();

      if (!mounted) return;

      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('Failed to retrieve Maps API key');
      }

      if (!mounted) return;

      setState(() {
        _apiKey = apiKey;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingView();
    }

    if (_hasError || _apiKey == null) {
      return _buildErrorView();
    }

    // Only render map when we have a valid API key
    // Wrap in error boundary to catch runtime map errors
    return Container(
      child: GoogleMap(
        initialCameraPosition: widget.initialPosition,
        mapType: widget.mapType,
        myLocationEnabled: widget.myLocationEnabled,
        myLocationButtonEnabled: widget.myLocationButtonEnabled,
        zoomControlsEnabled: widget.zoomControlsEnabled,
        compassEnabled: widget.compassEnabled,
        mapToolbarEnabled: widget.mapToolbarEnabled,
        markers: widget.markers ?? {},
        onMapCreated: (controller) {
          if (widget.onMapCreated != null) {
            widget.onMapCreated!(controller);
          }
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      color: AppColors.paleLavender,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.royalPurple,
            ),
            SizedBox(height: 16),
            Text(
              'Loading map...',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Container(
      color: AppColors.paleLavender,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.map_outlined,
                size: 80,
                color: AppColors.lavender,
              ),
              const SizedBox(height: 16),
              Text(
                'Map Temporarily Unavailable',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.greyDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Google Maps API key needs to be configured.\nThe app will work normally once the key is set up.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.greyMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lavender),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To enable maps:',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.royalPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1. Get API key from Google Cloud Console\n2. Enable Maps JavaScript API\n3. Add key to Firestore: maps/config',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
