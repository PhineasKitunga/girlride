import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../config/maps_api_config.dart';

/// Secure service to retrieve Google Maps API keys from Firestore
/// Keys are stored in Firestore and never hardcoded in the app
class MapsConfigService {
  static final MapsConfigService _instance = MapsConfigService._internal();
  factory MapsConfigService() => _instance;
  MapsConfigService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Cache the API key in memory (not persisted to disk)
  String? _cachedApiKey;
  DateTime? _cacheTimestamp;
  static const _cacheDuration = Duration(hours: 1); // Refresh every hour

  /// Get the appropriate API key for the current platform
  Future<String?> getApiKey() async {
    try {
      // Check if we have a valid cached key
      if (_cachedApiKey != null && _cacheTimestamp != null) {
        if (DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
          return _cachedApiKey;
        }
      }

      // Determine the field name based on platform
      String fieldName;
      String fallbackKey;
      
      if (kIsWeb) {
        fieldName = 'api_web';
        fallbackKey = MapsApiConfig.webKey;
      } else if (Platform.isAndroid) {
        fieldName = 'api_android';
        fallbackKey = MapsApiConfig.androidKey;
      } else if (Platform.isIOS) {
        fieldName = 'api_ios';
        fallbackKey = MapsApiConfig.iosKey;
      } else {
        // Fallback for other platforms (macOS, Windows, Linux)
        fieldName = 'api_web';
        fallbackKey = MapsApiConfig.webKey;
      }

      try {
        // Try to fetch from Firestore first
        final configDoc = await _firestore
            .collection('maps')
            .doc('config')
            .get()
            .timeout(
              const Duration(seconds: 30),
              onTimeout: () => throw Exception('Timeout fetching API key'),
            );

        if (configDoc.exists) {
          final data = configDoc.data();
          if (data != null && data.containsKey(fieldName)) {
            final apiKey = data[fieldName] as String?;
            
            if (apiKey != null && apiKey.isNotEmpty && _isValidApiKeyFormat(apiKey)) {
              // Cache the key from Firestore
              _cachedApiKey = apiKey;
              _cacheTimestamp = DateTime.now();
              
              if (kDebugMode) {
                print('✅ Maps API key loaded from Firestore');
              }
              
              return apiKey;
            }
          }
        }
      } catch (firestoreError) {
        if (kDebugMode) {
          print('⚠️  Firestore fetch failed: $firestoreError');
          print('📍 Using fallback API key for development');
        }
      }

      // Fallback to environment variable or Firestore
      if (fallbackKey.isNotEmpty && _isValidApiKeyFormat(fallbackKey)) {
        _cachedApiKey = fallbackKey;
        _cacheTimestamp = DateTime.now();
        
        if (kDebugMode) {
          print('✅ Using API key from environment variables');
        }
        
        return fallbackKey;
      }

      // No valid key available
      if (kDebugMode) {
        print('❌ No valid API key available!');
        print('💡 Set up Firestore: Create collection "maps" > document "config"');
        print('   with fields: api_android, api_ios, api_web');
        print('💡 OR build with environment variables:');
        print('   flutter run --dart-define=MAPS_API_KEY_WEB=your_key');
      }
      
      return null;
      
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in getApiKey: $e');
      }
      // Clear cache on error
      _cachedApiKey = null;
      _cacheTimestamp = null;
      return null;
    }
  }

  /// Basic validation of API key format
  bool _isValidApiKeyFormat(String apiKey) {
    // Google API keys typically start with "AIza" and are 39 characters long
    // But allow shorter keys for development/testing
    return apiKey.startsWith('AIza') && apiKey.length >= 20;
  }

  /// Clear the cached API key (useful for logout or security purposes)
  void clearCache() {
    _cachedApiKey = null;
    _cacheTimestamp = null;
  }

  /// Get current platform name for debugging
  String getCurrentPlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    if (Platform.isLinux) return 'linux';
    return 'unknown';
  }
}
