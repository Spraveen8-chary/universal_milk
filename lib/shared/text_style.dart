import 'package:flutter/material.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

// Display Styles
TextStyle displayLargeStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 28, maxFontSize: 36),
      fontWeight: FontWeight.bold,
      color: kcPrimaryTextColor,
      height: 1.2,
    );

TextStyle displayMediumStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24, maxFontSize: 32),
      fontWeight: FontWeight.bold,
      color: kcPrimaryTextColor,
      height: 1.2,
    );

TextStyle displaySmallStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20, maxFontSize: 28),
      fontWeight: FontWeight.bold,
      color: kcPrimaryTextColor,
      height: 1.2,
    );

// Heading Styles
TextStyle heading1Style(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24, maxFontSize: 28),
      fontWeight: FontWeight.w700,
      color: kcPrimaryTextColor,
    );

TextStyle heading2Style(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20, maxFontSize: 24),
      fontWeight: FontWeight.w600,
      color: kcPrimaryTextColor,
    );

TextStyle heading3Style(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18, maxFontSize: 20),
      fontWeight: FontWeight.w600,
      color: kcPrimaryTextColor,
    );

// Body Styles
TextStyle bodyStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16, maxFontSize: 18),
      color: kcSecondaryTextColor,
      height: 1.5,
    );

TextStyle bodyLargeStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18, maxFontSize: 20),
      color: kcSecondaryTextColor,
      height: 1.5,
    );

TextStyle bodySmallStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14, maxFontSize: 16),
      color: kcSecondaryTextColor,
      height: 1.5,
    );

// Button Styles
TextStyle buttonStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16, maxFontSize: 18),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );

TextStyle buttonLargeStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18, maxFontSize: 20),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );

// Special Styles
TextStyle linkStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16, maxFontSize: 18),
      color: kcPrimaryColor,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
    );

TextStyle captionStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 12, maxFontSize: 14),
      color: kcSecondaryTextColor.withOpacity(0.8),
    );

TextStyle errorStyle(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14, maxFontSize: 16),
      color: kcErrorColor,
      fontWeight: FontWeight.w500,
    );
