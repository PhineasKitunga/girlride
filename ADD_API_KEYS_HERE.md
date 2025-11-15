# 🔐 Secure API Key Setup

**Your API keys are NEVER hardcoded in the app!** We use two secure methods:

---

## Method 1: Firestore (Recommended for Production) ⭐

This is the most secure method - keys are stored in Firestore and fetched at runtime.

### Setup Steps:

1. **Open Firebase Console**: https://console.firebase.google.com/
2. **Go to Firestore Database**
3. **Create Collection**: `maps`
4. **Create Document**: `config`
5. **Add Fields**:
   ```
   api_android: "your_full_android_api_key_here"
   api_ios: "your_full_ios_api_key_here"
   api_web: "your_full_web_api_key_here"
   ```
6. **Deploy Security Rules**:
   - Go to Firestore → Rules
   - Copy content from `firestore.rules`
   - Publish

7. **Run the app** - Keys will be fetched automatically!

### Advantages:
✅ Keys never in source code  
✅ Can update keys without rebuilding app  
✅ Works for all users automatically  
✅ Protected by Firestore security rules  

---

## Method 2: Environment Variables (For Development)

Pass API keys at build time using command-line arguments.

### For Development/Testing:

#### Windows:
```powershell
flutter run -d chrome --dart-define=MAPS_API_KEY_WEB=your_web_api_key
```

#### Mac/Linux:
```bash
flutter run -d chrome --dart-define=MAPS_API_KEY_WEB=your_web_api_key
```

### For Production Builds:

#### Windows:
```cmd
set MAPS_API_KEY_ANDROID=your_android_key
set MAPS_API_KEY_IOS=your_ios_key
set MAPS_API_KEY_WEB=your_web_key
build.bat
```

#### Mac/Linux:
```bash
export MAPS_API_KEY_ANDROID=your_android_key
export MAPS_API_KEY_IOS=your_ios_key
export MAPS_API_KEY_WEB=your_web_key
./build.sh
```

### Advantages:
✅ Keys never in source code  
✅ Different keys per environment (dev/staging/prod)  
✅ Can't be extracted from app  

---

## For CI/CD (GitHub Actions, etc.)

Add secrets to your CI/CD platform and use them in build:

```yaml
# .github/workflows/build.yml
- name: Build Flutter app
  run: |
    flutter build web \
      --dart-define=MAPS_API_KEY_ANDROID=${{ secrets.MAPS_API_KEY_ANDROID }} \
      --dart-define=MAPS_API_KEY_IOS=${{ secrets.MAPS_API_KEY_IOS }} \
      --dart-define=MAPS_API_KEY_WEB=${{ secrets.MAPS_API_KEY_WEB }}
```

---

## Get Your API Keys

1. Go to: https://console.cloud.google.com/apis/credentials
2. Select project: `girlride-1`
3. Copy your 3 API keys (39 characters each, starting with "AIza")

---

## Security Notes

❌ **NEVER** commit API keys to Git  
❌ **NEVER** hardcode keys in source files  
✅ **ALWAYS** use Firestore or environment variables  
✅ **ALWAYS** restrict keys in Google Cloud Console  
✅ **ALWAYS** add `*.env` to `.gitignore`  

---

## Quick Start (Recommended)

**Use Firestore method** - it's the easiest and most secure for production!

### Option 2: Use Firestore (Production)
1. Open Firebase Console
2. Go to Firestore Database
3. Create collection: `maps`
4. Create document: `config`
5. Add these fields with YOUR complete keys:
   ```
   api_android: "YOUR_COMPLETE_ANDROID_KEY"
   api_ios: "YOUR_COMPLETE_IOS_KEY"
   api_web: "YOUR_COMPLETE_WEB_KEY"
   ```

## Get Your API Keys

1. Go to: https://console.cloud.google.com/
2. Select your project: `girlride-1`
3. Go to: APIs & Services → Credentials
4. Copy your API keys (should be 39 characters each, starting with "AIza")

## Example of Complete Key
```
AIzaSyAyYfrw-fdBkTysGYflNNNN2um2U-ABCDEFGHIJK
└──────────────────39 characters──────────────────┘
```

Your keys appear to be truncated. Make sure to copy the ENTIRE key.

## Testing
After adding keys:
1. Hot reload the app (press 'r' in terminal)
2. Map should load without errors
3. Check console for: `✅ Maps API key loaded`

## Security Note
- Option 1 (hardcoded) is OK for development
- Option 2 (Firestore) is REQUIRED for production
- Never commit API keys to Git!
