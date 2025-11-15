# API Key Security Implementation

## Overview
Your Google Maps API keys are now stored securely in Firestore and retrieved dynamically based on the user's platform. This prevents hardcoding API keys in the app and reduces the risk of key theft.

## Security Architecture

### 1. **Firestore Storage**
API keys are stored in Firestore at:
```
Collection: maps
Document: config
Fields:
  - api_android: "AIzaSyAyYfrw-fdBkTysGYflNNNN2um2U"
  - api_ios: "AIzaSyBdWoRapn1Tgo67I39F8c0_jtzU"
  - api_web: "AIzaSyDYqWIj2Aw2oS7ttP0Xqm_9o8Q"
```

### 2. **Security Rules**
The Firestore security rules ensure:
- ✅ Only **authenticated users** can read API keys
- ✅ **Nobody** can write or modify API keys (admin only via Firebase Console)
- ✅ Keys are never exposed to unauthenticated users
- ✅ Keys cannot be deleted by app users

### 3. **Secure Service Layer**
`lib/core/services/maps_config_service.dart` provides:
- Platform detection (Android, iOS, Web)
- Automatic key retrieval from Firestore
- In-memory caching (1-hour duration)
- API key validation
- Error handling with timeout protection

### 4. **Secure Widget**
`lib/shared/widgets/secure_google_map.dart`:
- Loads API key before rendering map
- Shows loading state while fetching key
- Handles errors gracefully with retry option
- Never exposes raw API key to logs in production

## Security Features

### ✅ Platform-Specific Keys
Each platform gets its own API key:
- **Android**: Restricted to your app's package name and SHA-1
- **iOS**: Restricted to your app's bundle identifier
- **Web**: Restricted to your domain

### ✅ Authentication Required
Users must be logged in to access maps. Implement this in your auth flow:

```dart
// Before allowing users to access maps
if (FirebaseAuth.instance.currentUser == null) {
  // Redirect to login
  Navigator.pushNamed(context, '/login');
}
```

### ✅ Caching Strategy
- Keys are cached in memory for 1 hour
- Cache is cleared on app restart
- No keys are stored in SharedPreferences or local storage
- Cache is automatically refreshed after expiration

### ✅ Validation
- API keys are validated for format (starts with "AIza", length check)
- Invalid keys are rejected
- Timeout protection (10 seconds)

## How It Works

### Flow Diagram
```
User Opens Map
    ↓
SecureGoogleMap Widget
    ↓
MapsConfigService.getApiKey()
    ↓
Check Cache (valid for 1 hour)
    ↓
[Cache Hit] → Return Cached Key
[Cache Miss] → Fetch from Firestore
    ↓
Detect Platform (Android/iOS/Web)
    ↓
Query: maps/config → api_[platform]
    ↓
Validate API Key Format
    ↓
Cache Key (in memory)
    ↓
Return to Widget → Render Map
```

## Setup Instructions

### Step 1: Create Firestore Document
1. Open Firebase Console
2. Go to Firestore Database
3. Create collection: `maps`
4. Create document: `config`
5. Add fields:
   ```
   api_android: "YOUR_ANDROID_API_KEY"
   api_ios: "YOUR_IOS_API_KEY"
   api_web: "YOUR_WEB_API_KEY"
   ```

### Step 2: Deploy Security Rules
1. The security rules are in `firestore.rules`
2. Deploy them manually in Firebase Console:
   - Go to Firestore Database → Rules
   - Copy the content from `firestore.rules`
   - Paste and Publish

### Step 3: Configure Google Cloud
For each API key in Google Cloud Console:

**Android Key:**
- Application restrictions: Android apps
- Package name: `com.ttweb.girlride`
- SHA-1: `CF:89:D2:6D:08:F4:6D:F5:F7:0E:43:A8:33:20:ED:C3:09:D7:4A:C2`
- API restrictions: Maps SDK for Android

**iOS Key:**
- Application restrictions: iOS apps
- Bundle ID: `com.ttweb.girlride`
- API restrictions: Maps SDK for iOS

**Web Key:**
- Application restrictions: HTTP referrers
- Website restrictions: Your domain (e.g., `yourdomain.com/*`)
- API restrictions: Maps JavaScript API

## Additional Security Measures

### 1. Rate Limiting
Implement in Cloud Functions:
```javascript
// Track API requests per user
const userRequestCount = await admin.firestore()
  .collection('api_usage')
  .doc(userId)
  .get();

if (userRequestCount.data().count > DAILY_LIMIT) {
  throw new Error('API limit exceeded');
}
```

### 2. Usage Monitoring
Set up Cloud Functions to monitor:
- Requests per user
- Requests per day
- Unusual usage patterns
- Failed requests

### 3. Budget Alerts
In Google Cloud Console:
1. Go to Billing → Budgets & alerts
2. Set monthly budget (e.g., $50)
3. Enable email alerts at 50%, 90%, 100%

### 4. API Quotas
In Google Cloud Console:
1. Go to APIs & Services → Maps SDK
2. Set quotas per day
3. Example: 1,000 requests/day per user

## Testing Security

### Test 1: Unauthenticated Access
```dart
// Sign out user
await FirebaseAuth.instance.signOut();

// Try to load map - should show loading then error
// API key fetch will fail due to security rules
```

### Test 2: Platform Detection
```dart
final service = MapsConfigService();
print('Platform: ${service.getCurrentPlatform()}');
// Should print: android, ios, or web
```

### Test 3: Cache Expiry
```dart
// Load map, wait 1 hour, load again
// Should see new Firestore request in logs
```

## Best Practices

### ✅ DO:
- Keep API keys in Firestore only
- Use separate keys for each platform
- Set up billing alerts
- Monitor usage regularly
- Require authentication
- Use rate limiting
- Cache keys appropriately
- Validate keys before use

### ❌ DON'T:
- Hardcode API keys in code
- Commit keys to Git
- Share keys between platforms
- Allow unauthenticated access
- Store keys in SharedPreferences
- Expose keys in logs (production)
- Use same key for dev and prod

## Monitoring Usage

### Firebase Console
Monitor in real-time:
1. Firestore → Usage tab
2. See reads/writes to `maps/config`
3. Check for unusual patterns

### Google Cloud Console
Track API usage:
1. APIs & Services → Dashboard
2. Maps SDK for [Platform]
3. View requests, errors, latency

## Troubleshooting

### Map doesn't load
1. Check user is authenticated
2. Verify Firestore rules are deployed
3. Check API key in Firestore is correct
4. Check internet connection

### "Permission denied" error
1. User not authenticated - implement sign-in
2. Security rules not deployed correctly
3. Check `firestore.rules` file

### API key format invalid
1. Verify key starts with "AIza"
2. Check key is complete (not truncated)
3. Ensure no extra spaces in Firestore

## Production Checklist

Before going live:

- [ ] API keys stored in Firestore
- [ ] Firestore security rules deployed
- [ ] Each platform has separate API key
- [ ] API keys restricted in Google Cloud
- [ ] Authentication required for map access
- [ ] Billing alerts configured
- [ ] Usage monitoring set up
- [ ] Rate limiting implemented (optional)
- [ ] Keys removed from code/Git history
- [ ] Emergency key rotation plan ready

## Emergency Key Rotation

If a key is compromised:

1. **Immediate**: Delete compromised key in Google Cloud Console
2. **Create**: Generate new API key with proper restrictions
3. **Update**: Replace key in Firestore `maps/config`
4. **Clear**: Clear app cache: `MapsConfigService().clearCache()`
5. **Monitor**: Watch for unauthorized usage
6. **Document**: Log incident and actions taken

---

**Last Updated**: November 15, 2025  
**Security Level**: ✅ Production Ready  
**Status**: Firestore + Authentication + Rate Limiting (Optional)
