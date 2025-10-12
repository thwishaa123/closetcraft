import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Responsive utility class for handling different screen sizes
/// Optimized for iPhone 15, 16, and 17 Pro Max devices
class ResponsiveUtils {
  // iPhone Pro Max screen dimensions
  static const double iPhone15ProMaxWidth = 430.0; // 2796x1290 logical pixels
  static const double iPhone15ProMaxHeight = 932.0;

  static const double iPhone16ProMaxWidth = 430.0; // 2868x1320 logical pixels
  static const double iPhone16ProMaxHeight = 932.0;

  static const double iPhone17ProMaxWidth = 430.0; // 2868x1320 logical pixels
  static const double iPhone17ProMaxHeight = 932.0;

  // Breakpoints for different device types
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;

  // iPhone Pro Max specific breakpoints
  static const double iPhoneProMaxBreakpoint = 430.0;
  static const double iPhoneProMaxHeightBreakpoint = 900.0;

  /// Get screen type based on dimensions
  static ScreenType getScreenType(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (kIsWeb) {
      if (width >= desktopBreakpoint) return ScreenType.desktop;
      if (width >= tabletBreakpoint) return ScreenType.tablet;
      return ScreenType.mobile;
    }

    // For mobile platforms, prioritize height for iPhone Pro Max detection
    if (height >= iPhoneProMaxHeightBreakpoint) {
      if (width >= iPhoneProMaxBreakpoint) {
        return ScreenType.iPhoneProMax;
      }
      return ScreenType.desktop;
    }
    if (height >= 700) return ScreenType.tablet;
    return ScreenType.mobile;
  }

  /// Check if current device is iPhone Pro Max
  static bool isIPhoneProMax(BuildContext context) {
    return getScreenType(context) == ScreenType.iPhoneProMax;
  }

  /// Check if current device is tablet or larger
  static bool isTabletOrLarger(BuildContext context) {
    final screenType = getScreenType(context);
    return screenType == ScreenType.tablet ||
        screenType == ScreenType.desktop ||
        screenType == ScreenType.iPhoneProMax;
  }

  /// Get responsive padding based on screen type
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final screenType = getScreenType(context);
    final size = MediaQuery.of(context).size;

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return EdgeInsets.symmetric(
          horizontal: size.width * 0.05, // 5% of screen width
          vertical: size.height * 0.02, // 2% of screen height
        );
      case ScreenType.desktop:
        return EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.03,
        );
      case ScreenType.tablet:
        return EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.025,
        );
      case ScreenType.mobile:
        return EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.02,
        );
    }
  }

  /// Get responsive font size based on screen type and base size
  static double getResponsiveFontSize(
      BuildContext context, double baseFontSize) {
    final screenType = getScreenType(context);
    final size = MediaQuery.of(context).size;

    // Scale factor based on screen type
    double scaleFactor = 1.0;

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        // iPhone Pro Max has larger screens, so slightly increase font size
        scaleFactor = 1.1;
        break;
      case ScreenType.desktop:
        scaleFactor = 1.2;
        break;
      case ScreenType.tablet:
        scaleFactor = 1.15;
        break;
      case ScreenType.mobile:
        scaleFactor = 1.0;
        break;
    }

    // Additional scaling based on screen width for very large screens
    if (size.width > 400) {
      scaleFactor *= 1.05;
    }

    return baseFontSize * scaleFactor;
  }

  /// Get responsive icon size based on screen type
  static double getResponsiveIconSize(
      BuildContext context, double baseIconSize) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return baseIconSize * 1.15;
      case ScreenType.desktop:
        return baseIconSize * 1.3;
      case ScreenType.tablet:
        return baseIconSize * 1.2;
      case ScreenType.mobile:
        return baseIconSize;
    }
  }

  /// Get responsive spacing based on screen type
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return baseSpacing * 1.1;
      case ScreenType.desktop:
        return baseSpacing * 1.3;
      case ScreenType.tablet:
        return baseSpacing * 1.2;
      case ScreenType.mobile:
        return baseSpacing;
    }
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return 56.0; // Slightly larger for better touch targets
      case ScreenType.desktop:
        return 64.0;
      case ScreenType.tablet:
        return 60.0;
      case ScreenType.mobile:
        return 52.0;
    }
  }

  /// Get responsive card padding
  static EdgeInsets getResponsiveCardPadding(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return const EdgeInsets.all(24.0);
      case ScreenType.desktop:
        return const EdgeInsets.all(32.0);
      case ScreenType.tablet:
        return const EdgeInsets.all(28.0);
      case ScreenType.mobile:
        return const EdgeInsets.all(20.0);
    }
  }

  /// Get responsive grid cross axis count
  static int getResponsiveGridCrossAxisCount(BuildContext context) {
    final screenType = getScreenType(context);
    final width = MediaQuery.of(context).size.width;

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        // For iPhone Pro Max, use 2 columns for better layout
        return 2;
      case ScreenType.desktop:
        return (width / 300).floor().clamp(2, 4);
      case ScreenType.tablet:
        return (width / 250).floor().clamp(2, 3);
      case ScreenType.mobile:
        return 2;
    }
  }

  /// Get responsive child aspect ratio for grid items
  static double getResponsiveChildAspectRatio(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return 0.85; // Slightly taller for better visual balance
      case ScreenType.desktop:
        return 0.9;
      case ScreenType.tablet:
        return 0.88;
      case ScreenType.mobile:
        return 0.8;
    }
  }

  /// Get responsive container constraints
  static BoxConstraints getResponsiveContainerConstraints(
      BuildContext context) {
    final screenType = getScreenType(context);
    final size = MediaQuery.of(context).size;

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return BoxConstraints(
          maxWidth: size.width * 0.95,
          maxHeight: size.height * 0.9,
        );
      case ScreenType.desktop:
        return BoxConstraints(
          maxWidth: 1200,
          maxHeight: size.height * 0.9,
        );
      case ScreenType.tablet:
        return BoxConstraints(
          maxWidth: size.width * 0.9,
          maxHeight: size.height * 0.85,
        );
      case ScreenType.mobile:
        return BoxConstraints(
          maxWidth: size.width * 0.95,
          maxHeight: size.height * 0.9,
        );
    }
  }

  /// Get responsive text style
  static TextStyle getResponsiveTextStyle(
    BuildContext context, {
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize),
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Get responsive app bar height
  static double getResponsiveAppBarHeight(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return 60.0; // Slightly taller for better proportions
      case ScreenType.desktop:
        return 70.0;
      case ScreenType.tablet:
        return 65.0;
      case ScreenType.mobile:
        return 56.0;
    }
  }

  /// Get responsive bottom navigation bar height
  static double getResponsiveBottomNavHeight(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.iPhoneProMax:
        return 80.0; // Account for home indicator
      case ScreenType.desktop:
        return 70.0;
      case ScreenType.tablet:
        return 75.0;
      case ScreenType.mobile:
        return 70.0;
    }
  }

  /// Check if device has safe area insets (notch, home indicator)
  static bool hasSafeAreaInsets(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return padding.top > 0 || padding.bottom > 0;
  }

  /// Get safe area aware padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: padding.top > 0 ? padding.top + 10 : 10,
      bottom: padding.bottom > 0 ? padding.bottom + 10 : 10,
      left: 0,
      right: 0,
    );
  }
}

/// Screen type enumeration
enum ScreenType {
  mobile,
  tablet,
  desktop,
  iPhoneProMax,
}

/// Extension methods for easier responsive usage
extension ResponsiveExtension on BuildContext {
  ScreenType get screenType => ResponsiveUtils.getScreenType(this);
  bool get isIPhoneProMax => ResponsiveUtils.isIPhoneProMax(this);
  bool get isTabletOrLarger => ResponsiveUtils.isTabletOrLarger(this);

  EdgeInsets get responsivePadding =>
      ResponsiveUtils.getResponsivePadding(this);
  EdgeInsets get responsiveCardPadding =>
      ResponsiveUtils.getResponsiveCardPadding(this);
  EdgeInsets get safeAreaPadding => ResponsiveUtils.getSafeAreaPadding(this);

  double responsiveFontSize(double baseSize) =>
      ResponsiveUtils.getResponsiveFontSize(this, baseSize);
  double responsiveIconSize(double baseSize) =>
      ResponsiveUtils.getResponsiveIconSize(this, baseSize);
  double responsiveSpacing(double baseSpacing) =>
      ResponsiveUtils.getResponsiveSpacing(this, baseSpacing);
  double get responsiveButtonHeight =>
      ResponsiveUtils.getResponsiveButtonHeight(this);
  double get responsiveAppBarHeight =>
      ResponsiveUtils.getResponsiveAppBarHeight(this);
  double get responsiveBottomNavHeight =>
      ResponsiveUtils.getResponsiveBottomNavHeight(this);

  int get responsiveGridCrossAxisCount =>
      ResponsiveUtils.getResponsiveGridCrossAxisCount(this);
  double get responsiveChildAspectRatio =>
      ResponsiveUtils.getResponsiveChildAspectRatio(this);
  BoxConstraints get responsiveContainerConstraints =>
      ResponsiveUtils.getResponsiveContainerConstraints(this);

  TextStyle responsiveTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) =>
      ResponsiveUtils.getResponsiveTextStyle(
        this,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
}
