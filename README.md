# 🚗 GirlRide - Safe Rides. For Women. By Women.

A premium, safety-first, women-only ride-hailing mobile application built with Flutter. GirlRide creates a secure environment where female riders are matched exclusively with verified female drivers.

## 🎨 Design Philosophy

GirlRide features a **premium, minimalistic, modern, soft, and professional** UI/UX design with:

- **Color Palette**: Royal Purple (#6A0DAD), Lavender (#CFA9FF), White (#FFFFFF)
- **Secondary Colors**: Soft Pink (#F9E6FF), Deep Violet (#4B0B82)
- **Visual Style**: Rounded corners, soft shadows, wide spacing, clean typography, subtle gradients
- **User Experience**: Calming, secure, and feminine throughout

## ✨ Key Features

### 🔐 Safety Features
- **Panic Button**: One-tap emergency alert system with countdown
- **Real-Time Tracking**: Live GPS monitoring with route verification
- **Trusted Contacts**: Automatic trip sharing with emergency contacts
- **Verified Drivers**: Rigorous background checks and identity verification
- **Safety Center**: Comprehensive safety guidelines and tools
- **Audio Recording**: Automatic recording during emergency situations

### 🚕 Ride Features
- **Standard Rides**: Affordable everyday transportation
- **Night-Safe Rides**: Extra verified drivers for nighttime travel
- **Scheduled Rides**: Book your ride in advance
- **Live Driver Tracking**: Real-time driver location and ETA
- **In-App Chat**: Secure messaging without sharing phone numbers
- **Driver Ratings**: Community-driven safety and quality assurance

### 👤 User Features
- **Identity Verification**: ID scan and selfie matching
- **Profile Management**: Complete profile customization
- **Ride History**: Detailed trip records with safety scores
- **Payment Integration**: Multiple payment methods support
- **Notification System**: Real-time alerts and updates

## 📱 App Screens

### Authentication Flow
1. **Splash Screen** - Animated logo with app slogan
2. **Onboarding** - 5-page introduction to safety features
3. **Welcome Screen** - Sign in or create account
4. **Login** - Phone number authentication
5. **OTP Verification** - 6-digit code verification
6. **Registration** - Complete profile setup
7. **Identity Verification** - ID and selfie verification

### Main Features
8. **Home Dashboard** - Map view with quick actions
9. **Ride Request** - Location selection and ride type
10. **Driver Matching** - Finding verified female driver
11. **Driver Assigned** - Driver details and communication
12. **Live Tracking** - Real-time GPS with progress timeline
13. **Panic/Emergency** - Emergency alert activation
14. **Ride Completion** - Rating and safety confirmation

### Additional Screens
15. **Safety Center** - Emergency features and guidelines
16. **Trusted Contacts** - Manage emergency contacts
17. **Profile** - User settings and statistics
18. **Ride History** - Past trips with safety scores
19. **Payment Methods** - Card and mobile money
20. **Chat** - Secure driver communication

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart      # App-wide constants
│   └── theme/
│       ├── app_colors.dart          # Color palette
│       ├── app_text_styles.dart     # Typography system
│       └── app_theme.dart           # Theme configuration
├── features/
│   ├── auth/
│   │   ├── welcome_screen.dart
│   │   ├── login_screen.dart
│   │   ├── otp_verification_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── onboarding/
│   │   └── onboarding_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   ├── ride/
│   │   ├── ride_request_screen.dart
│   │   ├── matching_screen.dart
│   │   ├── driver_assigned_screen.dart
│   │   └── live_tracking_screen.dart
│   ├── safety/
│   │   ├── safety_center_screen.dart
│   │   └── panic_screen.dart
│   └── splash/
│       └── splash_screen.dart
├── shared/
│   └── widgets/
│       ├── buttons.dart             # Reusable button components
│       ├── cards.dart               # Card components
│       └── text_fields.dart         # Input components
└── main.dart                        # App entry point
```

## 🎨 Design System

### Color Tokens
```dart
// Primary
Royal Purple: #6A0DAD
Lavender: #CFA9FF
White: #FFFFFF

// Secondary
Soft Pink: #F9E6FF
Deep Violet: #4B0B82
Dark Charcoal: #2A2A2A

// Functional
Success: #4CAF50
Warning: #FFA726
Error/Panic: #D32F2F
```

### Typography
- **Display**: Bold, 32-24px
- **Headline**: SemiBold, 22-18px
- **Body**: Regular, 16-12px
- **Label**: SemiBold, 14-10px

### Spacing System
- XS: 4px | S: 8px | M: 16px | L: 24px | XL: 32px | XXL: 48px

### Border Radius
- S: 8px | M: 12px | L: 16px | XL: 24px | Circle: 999px

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS: Xcode (for iOS development)
- Android: Android SDK

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/girlride.git
cd girlride
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# Development mode
flutter run

# Release mode
flutter run --release
```

### Building

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## 🧩 Component Library

### Buttons
- `PrimaryButton` - Gradient purple button with loading state
- `SecondaryButton` - Outlined button
- `PanicButton` - Animated emergency button with pulse effect

### Cards
- `SoftCard` - White card with lavender shadow
- `QuickActionCard` - Icon-based action card
- `FeatureCard` - Feature description card
- `InfoCard` - Information display card

### Text Fields
- `CustomTextField` - Standard input with label
- `SearchTextField` - Location search input

## 🔒 Security Features

- End-to-end encrypted communications
- Secure payment processing
- ID verification system
- Background check integration
- Real-time location monitoring
- Emergency alert system
- Audio recording capabilities
- Route deviation detection

## 📊 Technical Stack

- **Framework**: Flutter 3.9+
- **Language**: Dart
- **State Management**: setState (can be upgraded to Provider/Riverpod/Bloc)
- **Navigation**: Named routes
- **UI**: Material Design 3
- **Architecture**: Feature-first modular structure

## 🚀 Future Enhancements

- [ ] Google Maps integration for real mapping
- [ ] Firebase authentication and real-time database
- [ ] Push notifications
- [ ] Payment gateway integration (Stripe, PayPal)
- [ ] Driver companion app
- [ ] Admin dashboard
- [ ] Multi-language support
- [ ] Dark mode
- [ ] Accessibility features
- [ ] Analytics integration

## 👥 Contributing

Contributions are welcome! Please read our contributing guidelines before submitting pull requests.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 💜 About GirlRide

GirlRide is more than just a ride-hailing app—it's a commitment to women's safety and empowerment. Every feature is designed with security in mind, creating a trusted community where women can travel confidently.

**Safe Rides. For Women. By Women.**

---

Made with 💜 by the GirlRide Team

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
