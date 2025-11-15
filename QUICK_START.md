# 🚀 GirlRide - Quick Start Guide

## Welcome to GirlRide! 💜

This guide will help you get the app running in minutes.

---

## 📋 Prerequisites

Before you begin, ensure you have:

- ✅ **Flutter SDK** installed (version 3.9.0 or higher)
- ✅ **Dart SDK** (comes with Flutter)
- ✅ **IDE**: VS Code or Android Studio
- ✅ **Device**: Android emulator, iOS simulator, or physical device

### Check Your Setup

```bash
flutter doctor
```

This command should show no errors for the platforms you want to target.

---

## 🏃 Run the App in 3 Steps

### Step 1: Get Dependencies

Open terminal in the project root and run:

```bash
flutter pub get
```

This installs all required packages.

### Step 2: Run the App

```bash
flutter run
```

Or select your device in VS Code/Android Studio and press F5 (or click Run).

### Step 3: Explore!

The app will start with the splash screen and automatically navigate through:
1. Splash Screen (3 seconds)
2. Onboarding (5 pages)
3. Welcome Screen
4. From there you can explore all features!

---

## 🎯 Navigation Shortcuts

### Direct Screen Access

You can test individual screens by modifying the `initialRoute` in `lib/main.dart`:

```dart
MaterialApp(
  // Change this line to jump to any screen
  initialRoute: '/',  // Change to any route below
  routes: {
    '/': (context) => const SplashScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/welcome': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/home': (context) => const HomeScreen(),
    '/ride-request': (context) => const RideRequestScreen(),
    '/matching': (context) => const MatchingScreen(),
    '/driver-assigned': (context) => const DriverAssignedScreen(),
    '/safety-center': (context) => const SafetyCenterScreen(),
    '/profile': (context) => const ProfileScreen(),
  },
)
```

**Example**: To start directly at the home screen, change:
```dart
initialRoute: '/home',
```

---

## 🎨 Hot Tips

### Hot Reload (r)
Made a UI change? Just press `r` in the terminal to hot reload without losing state.

### Hot Restart (R)
Need to restart the app completely? Press `Shift + R` or `R` in the terminal.

### Quick Navigation
Once in the app:
- Use the **back button** on screens to navigate back
- Use **bottom navigation** on home screen to switch between tabs
- Tap buttons to explore different flows

---

## 📱 Recommended Testing Flow

### Flow 1: Complete User Journey
1. Start app → Splash Screen
2. View Onboarding (all 5 pages)
3. Welcome Screen → "Sign In"
4. Enter phone number
5. Enter OTP (any 6 digits work - UI only)
6. Home Screen
7. Tap "Where to?" → Request Ride
8. See driver matching animation
9. View driver details
10. Track ride (simulated)

### Flow 2: Safety Features
1. Home Screen
2. Tap "Safety Center"
3. Read safety features
4. Back to home
5. Tap **Panic Button** (red circle) on map
6. See emergency countdown
7. Cancel before activation

### Flow 3: Profile & Settings
1. Home Screen
2. Bottom nav → "Profile"
3. View profile stats
4. Explore menu items

---

## 🎨 Customization Quick Tips

### Change Theme Colors

Edit `lib/core/theme/app_colors.dart`:

```dart
// Primary Colors
static const Color royalPurple = Color(0xFF6A0DAD);  // Change this!
static const Color lavender = Color(0xFFCFA9FF);     // Or this!
```

### Change App Name

Edit `lib/core/constants/app_constants.dart`:

```dart
static const String appName = 'GirlRide';  // Your name here
static const String appSlogan = 'Your slogan here';
```

### Modify Button Styles

Edit `lib/shared/widgets/buttons.dart`:

```dart
// PrimaryButton, SecondaryButton, PanicButton
```

---

## 🐛 Common Issues & Solutions

### Issue: "Flutter not recognized"
**Solution**: Add Flutter to your PATH. See: https://docs.flutter.dev/get-started/install

### Issue: Dependencies not found
**Solution**: Run `flutter pub get` in the project root.

### Issue: Build errors
**Solution**: 
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Hot reload not working
**Solution**: Do a hot restart (`Shift + R`) or full restart.

### Issue: Simulator/Emulator not detected
**Solution**: 
- **Android**: Start Android emulator from Android Studio
- **iOS**: `open -a Simulator` (Mac only)
- **Physical device**: Enable USB debugging and connect

---

## 📂 Project Structure at a Glance

```
lib/
├── main.dart                    ← App entry point, START HERE
├── core/
│   ├── constants/              ← App constants
│   └── theme/                  ← Colors, typography, theme
├── features/                   ← All screens organized by feature
│   ├── auth/                   ← Login, register, OTP
│   ├── home/                   ← Main dashboard
│   ├── onboarding/             ← First-time user intro
│   ├── profile/                ← User profile
│   ├── ride/                   ← Ride booking & tracking
│   ├── safety/                 ← Safety center, panic
│   └── splash/                 ← Splash screen
└── shared/
    └── widgets/                ← Reusable components
```

---

## 🎯 What to Test

### ✅ Visual Elements
- [ ] Splash screen animation
- [ ] Onboarding page transitions
- [ ] Button hover effects
- [ ] Card shadows
- [ ] Color consistency
- [ ] Typography hierarchy
- [ ] Icon sizes

### ✅ Interactions
- [ ] Button taps
- [ ] Navigation flow
- [ ] Back button behavior
- [ ] Bottom navigation tabs
- [ ] OTP input auto-focus
- [ ] Panic button animation

### ✅ Screens
- [ ] Splash (auto-navigates)
- [ ] Onboarding (5 pages)
- [ ] Welcome
- [ ] Login
- [ ] OTP Verification
- [ ] Registration
- [ ] Home
- [ ] Ride Request
- [ ] Matching
- [ ] Driver Assigned
- [ ] Live Tracking
- [ ] Panic/Emergency
- [ ] Safety Center
- [ ] Profile

---

## 🚀 Build for Production

### Android APK
```bash
flutter build apk --release
```
Find it in: `build/app/outputs/flutter-apk/app-release.apk`

### iOS
```bash
flutter build ios --release
```
Then use Xcode to archive and upload.

### Web
```bash
flutter build web
```
Deploy the `build/web` folder to your hosting.

---

## 📚 Learn More

### Official Documentation
- **README.md** - Project overview
- **DESIGN_SYSTEM.md** - Complete design specifications
- **SCREENS_REFERENCE.md** - All screens documented
- **IMPLEMENTATION_SUMMARY.md** - What's been built

### Code Comments
Every major component has inline comments explaining its purpose.

### Flutter Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design](https://m3.material.io/)
- [Dart Language](https://dart.dev/)

---

## 💡 Pro Tips

1. **Use Hot Reload**: Speeds up development 10x
2. **Check Logs**: Terminal shows helpful debug info
3. **Flutter DevTools**: Run `flutter pub global activate devtools` for advanced debugging
4. **Widget Inspector**: In VS Code, click "Inspect Widget" icon
5. **Performance Overlay**: Enable in Flutter DevTools to check FPS

---

## 🎉 You're Ready!

The app is fully functional as a **high-fidelity prototype**. 

All screens are navigable, all animations work, and the entire user flow is complete.

**To add backend functionality**, integrate:
- Firebase for authentication
- Google Maps SDK for real maps
- Cloud Firestore for database
- Cloud Functions for business logic

---

## 🆘 Need Help?

1. Check the documentation files
2. Read inline code comments
3. Search Flutter documentation
4. Check StackOverflow for Flutter questions

---

## ✨ Features to Explore

### Must-Try Features
1. **Panic Button Animation** - Pulsing red emergency button
2. **Onboarding Flow** - 5 beautiful intro screens
3. **OTP Input** - Auto-focus between fields
4. **Driver Matching** - Animated search with safety tips
5. **Bottom Navigation** - Switch between Home/Rides/Safety/Profile
6. **Profile Stats** - 3-column stat cards
7. **Safety Center** - Numbered safety guidelines
8. **Live Tracking** - Progress timeline at bottom

---

**Happy Coding! 💜**

**Safe Rides. For Women. By Women.**

---

*Last Updated: November 2025*
*Version: 1.0.0*
*Made with Flutter & 💜*
