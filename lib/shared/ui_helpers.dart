import 'package:flutter/material.dart';
import 'dart:math' as math;

// Horizontal Spacing
const Widget kHorizontalSpaceTiny = SizedBox(width: 4.0);
const Widget kHorizontalSpaceSmall = SizedBox(width: 8.0);
const Widget kHorizontalSpaceMedium = SizedBox(width: 16.0);
const Widget kHorizontalSpaceLarge = SizedBox(width: 24.0);
const Widget kHorizontalSpaceMassive = SizedBox(width: 48.0);

// Vertical Spacing
const Widget kSpaceTiny = SizedBox(height: 4.0);
const Widget kSpaceSmall = SizedBox(height: 8.0);
const Widget kSpaceMedium = SizedBox(height: 16.0);
const Widget kSpaceLarge = SizedBox(height: 24.0);
const Widget kSpaceMassive = SizedBox(height: 48.0);

// Screen Size Extensions
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenWidthFraction(
  BuildContext context, {
  double dividedBy = 1,
  double offsetBy = 0,
  double maxWidth = double.infinity,
}) {
  return math.min(
    (screenWidth(context) - offsetBy) / dividedBy,
    maxWidth,
  );
}

double screenHeightFraction(
  BuildContext context, {
  double dividedBy = 1,
  double offsetBy = 0,
  double maxHeight = double.infinity,
}) {
  return math.min(
    (screenHeight(context) - offsetBy) / dividedBy,
    maxHeight,
  );
}

// Responsive Font Size
double getResponsiveFontSize(
  BuildContext context, {
  double fontSize = 16,
  double maxFontSize = 20,
}) {
  final width = screenWidth(context);
  final baseFontSize = fontSize;
  
  // Scale font size based on screen width, but cap it at maxFontSize
  final responsiveFontSize = math.min(
    baseFontSize * (width / 375), // Scale based on 375px base width (iPhone)
    maxFontSize,
  );
  
  return responsiveFontSize;
}