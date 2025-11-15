import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';

// Splash & Onboarding
import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

// Authentication
import 'features/auth/welcome_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';

// Home & Ride
import 'features/home/home_screen.dart';
import 'features/ride/ride_request_screen.dart';
import 'features/ride/matching_screen.dart';
import 'features/ride/driver_assigned_screen.dart';

// Safety
import 'features/safety/safety_center_screen.dart';
import 'features/safety/panic_screen.dart';
import 'features/safety/trusted_contacts_screen.dart';

// Profile
import 'features/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const GirlRideApp());
}

class GirlRideApp extends StatelessWidget {
  const GirlRideApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
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
        '/panic': (context) => const PanicScreen(),
        '/trusted-contacts': (context) => const TrustedContactsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
