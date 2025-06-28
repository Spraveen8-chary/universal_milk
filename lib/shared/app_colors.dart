import 'package:flutter/material.dart';

// Primary Colors
const Color kcPrimaryColor = Color(0xFF3F51B5);
const Color kcSecondaryColor = Color(0xFF2196F3);
const Color kcAccentColor = Color(0xFFFF9800);

// Semantic Colors
const Color kcSuccessColor = Color(0xFF4CAF50);
const Color kcErrorColor = Color(0xFFE53935);
const Color kcWarningColor = Color(0xFFFFC107);
const Color kcInfoColor = Color(0xFF2196F3);

// Text Colors
const Color kcPrimaryTextColor = Color(0xFF212121);
const Color kcSecondaryTextColor = Color(0xFF757575);

// Background Colors
const Color kcSurfaceColor = Colors.white;
const Color kcBackgroundColor = Color(0xFFF5F5F5);
const Color kcCreamColor = Color(0xFFFFF8E1);

// Gradients
const LinearGradient kcPrimaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kcPrimaryColor,
    Color(0xFF5C6BC0),
  ],
);

// Shadows
const BoxShadow kcCardShadow = BoxShadow(
  color: Color(0x1A000000),
  blurRadius: 8,
  offset: Offset(0, 2),
);