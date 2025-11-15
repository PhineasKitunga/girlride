# Google Maps Setup Guide

## Overview
The GirlRide app now uses Google Maps to display real map views. To make it work, you need to configure API keys for each platform.

## Get Your Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing project
3. Enable these APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Maps JavaScript API (for Web)
4. Go to **Credentials** → **Create Credentials** → **API Key**
5. Copy your API key
6. **IMPORTANT**: Immediately restrict your API key (see below)

## Platform Configuration

### Android
1. Open `android/app/src/main/AndroidManifest.xml`
2. Add inside `<application>` tag:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_API_KEY"/>
```

### iOS
1. Open `ios/Runner/AppDelegate.swift`
2. Add at the top:
```swift
import GoogleMaps
```
3. In `application` method, add before `return`:
```swift
GMSServices.provideAPIKey("YOUR_IOS_API_KEY")
```

### Web
1. Open `web/index.html`
2. Add before `</head>`:
```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_WEB_API_KEY"></script>
```

### macOS
1. Open `macos/Runner/AppDelegate.swift`
2. Add at the top:
```swift
import GoogleMaps
```
3. In `applicationDidFinishLaunching` method, add:
```swift
GMSServices.provideAPIKey("YOUR_MACOS_API_KEY")
```

## Testing Without API Key

The map will show a "For development purposes only" watermark without proper API keys, but it will still work for testing.

## Protect Your API Key (CRITICAL!)

After creating your API key, you MUST set restrictions to prevent unauthorized usage and unexpected charges.

### Step 1: Set Application Restrictions

Click on your API key in the Credentials page, then:

#### For Android Key:
1. Under "Application restrictions", select **Android apps**
2. Click **Add an app**
3. Add package name: `com.ttweb.girlride`
4. Get SHA-1 fingerprint:
   ```bash
   # For debug builds
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   
   # For release builds (use your actual keystore)
   keytool -list -v -keystore your-release-key.keystore -alias your-key-alias
   ```
5. Copy the SHA-1 fingerprint and paste it
6. Click **Done** then **Save**

#### For iOS Key:
1. Under "Application restrictions", select **iOS apps**
2. Click **Add an app**
3. Add bundle identifier: `com.ttweb.girlride`
4. Click **Done** then **Save**

#### For Web Key:
1. Under "Application restrictions", select **HTTP referrers (web sites)**
2. Click **Add an item**
3. Add your domain (e.g., `yourdomain.com/*`, `localhost/*` for testing)
4. Click **Done** then **Save**

### Step 2: Set API Restrictions

On the same page:

1. Under "API restrictions", select **Restrict key**
2. Check ONLY the APIs you need:
   - ✅ **Maps SDK for Android** (for Android app)
   - ✅ **Maps SDK for iOS** (for iOS app)
   - ✅ **Maps JavaScript API** (for Web app)
   - ✅ **Geolocation API** (optional, for location services)
   - ✅ **Places API** (optional, for place searches)
3. Click **Save**

### Step 3: Create Separate Keys (Recommended)

For better security, create separate API keys for each platform:

1. **Android Key**: Restricted to Android apps only
2. **iOS Key**: Restricted to iOS apps only
3. **Web Key**: Restricted to HTTP referrers only

### Security Best Practices

1. ✅ **Always restrict API keys** immediately after creation
2. ✅ **Use separate keys** for each platform
3. ✅ **Never commit API keys** to version control
4. ✅ **Set up billing alerts** in Google Cloud to monitor usage
5. ✅ **Regularly review** API usage in the Cloud Console
6. ✅ **Rotate keys** if compromised
7. ✅ **Use environment variables** for keys in your code

### If Your Key Gets Compromised

1. Go to Google Cloud Console → Credentials
2. Delete the compromised key immediately
3. Create a new key with proper restrictions
4. Update your app with the new key

## Current Map Settings

- **Location**: Nairobi, Kenya (-1.286389, 36.817223)
- **Zoom**: 14.0
- **Features**: My location enabled, POI labels hidden
- **Style**: Clean, minimalist view

## Customization

To change the default location, edit `lib/features/home/home_screen.dart`:

```dart
initialCameraPosition: const CameraPosition(
  target: LatLng(YOUR_LATITUDE, YOUR_LONGITUDE),
  zoom: 14.0,
),
```

## Troubleshooting

### Map shows gray screen
- Check if API key is configured
- Verify APIs are enabled in Google Cloud Console
- Check internet connection

### "For development purposes only" watermark
- This means API key is missing or invalid
- Add proper API key for your platform

### Permission errors
- Ensure location permissions are configured in:
  - `android/app/src/main/AndroidManifest.xml`
  - `ios/Runner/Info.plist`

## Next Steps

1. Get your Google Maps API key
2. Configure it for your target platforms
3. Test the map on your device/emulator
4. Restrict the API key in Google Cloud Console

---

**Note**: For production, you must have valid API keys configured. The app will work in development mode but with watermarks.
