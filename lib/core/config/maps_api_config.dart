/// Google Maps API Configuration
/// 
/// This file uses compile-time environment variables to avoid hardcoding API keys
/// Keys are passed during build time and never stored in source code

class MapsApiConfig {
  /// Get API keys from environment variables (set during build)
  /// These are compile-time constants, not runtime variables
  
  static const String androidKey = String.fromEnvironment(
    'MAPS_API_KEY_ANDROID',
    defaultValue: '',
  );
  
  static const String iosKey = String.fromEnvironment(
    'MAPS_API_KEY_IOS',
    defaultValue: '',
  );
  
  static const String webKey = String.fromEnvironment(
    'MAPS_API_KEY_WEB',
    defaultValue: '',
  );
  
  /// Check if keys are configured
  static bool get hasAndroidKey => androidKey.isNotEmpty;
  static bool get hasIosKey => iosKey.isNotEmpty;
  static bool get hasWebKey => webKey.isNotEmpty;
}
