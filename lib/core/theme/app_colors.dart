import 'package:flutter/material.dart';

/// GirlRide App Color Palette
/// Premium, feminine, safety-focused color scheme
class AppColors {
  // Primary Colors
  static const Color royalPurple = Color(0xFF6A0DAD);
  static const Color lavender = Color(0xFFCFA9FF);
  static const Color white = Color(0xFFFFFFFF);

  // Secondary Colors
  static const Color softPink = Color(0xFFF9E6FF);
  static const Color deepViolet = Color(0xFF4B0B82);
  static const Color darkCharcoal = Color(0xFF2A2A2A);

  // Accent Colors
  static const Color lightLavender = Color(0xFFE8D5FF);
  static const Color paleLavender = Color(0xFFF5ECFF);
  static const Color mediumPurple = Color(0xFF8B3FBF);

  // Functional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color panicRed = Color(0xFFD32F2F);

  // Neutral Colors
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyMedium = Color(0xFFBDBDBD);
  static const Color greyDark = Color(0xFF757575);

  // Gradients
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [royalPurple, mediumPurple],
  );

  static const LinearGradient lavenderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lavender, lightLavender],
  );

  static const LinearGradient softGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softPink, paleLavender],
  );

  static const LinearGradient panicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [panicRed, Color(0xFFE57373)],
  );
}
