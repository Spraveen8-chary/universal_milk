import 'package:flutter/material.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  gradient,
  destructive,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isFullWidth;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isFullWidth = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    // Determine button height based on size
    final double height;
    switch (size) {
      case ButtonSize.small:
        height = 32;
        break;
      case ButtonSize.medium:
        height = 44;
        break;
      case ButtonSize.large:
        height = 52;
        break;
    }

    return Container(
      width: isFullWidth ? double.infinity : null,
      height: height,
      decoration: _getButtonDecoration(context, isEnabled),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size == ButtonSize.small ? 12 : 16,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getTextColor(context, isEnabled),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize:
                          isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: _getTextColor(context, isEnabled),
                            size: size == ButtonSize.small ? 16 : 20,
                          ),
                          kHorizontalSpaceSmall,
                        ],
                        Text(
                          text,
                          style: buttonStyle(context).copyWith(
                            color: _getTextColor(context, isEnabled),
                            fontSize: size == ButtonSize.small ? 14 : 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getButtonDecoration(BuildContext context, bool isEnabled) {
    final opacity = isEnabled ? 1.0 : 0.5;

    switch (variant) {
      case ButtonVariant.primary:
        return BoxDecoration(
          color: kcPrimaryColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonVariant.secondary:
        return BoxDecoration(
          color: kcSecondaryColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: kcPrimaryColor.withOpacity(opacity),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonVariant.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonVariant.gradient:
        return BoxDecoration(
          gradient: isEnabled
              ? kcPrimaryGradient
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kcPrimaryColor.withOpacity(0.5),
                    kcPrimaryColor.withOpacity(0.3),
                  ],
                ),
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonVariant.destructive:
        return BoxDecoration(
          color: kcErrorColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(8),
        );
    }
  }

  Color _getTextColor(BuildContext context, bool isEnabled) {
    final opacity = isEnabled ? 1.0 : 0.5;

    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.gradient:
      case ButtonVariant.destructive:
        return Colors.white.withOpacity(opacity);
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return kcPrimaryColor.withOpacity(opacity);
    }
  }
}
