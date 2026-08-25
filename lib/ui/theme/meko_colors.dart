import 'package:flutter/material.dart';

/// Centralised color constants for the Meko design system.
///
/// All values are extracted from the FlutterFlow mockup screenshots.
class MekoColors {
  MekoColors._();

  // ---------------------------------------------------------------------------
  // Primary Palette
  // ---------------------------------------------------------------------------

  /// Deep maroon — primary brand colour used for buttons, headers, active nav.
  static const Color primary = Color(0xFF6D1A1A);

  /// Slightly lighter maroon for pressed / hover states.
  static const Color primaryLight = Color(0xFF8B2E2E);

  /// Darker maroon for emphasis.
  static const Color primaryDark = Color(0xFF4E1212);

  // ---------------------------------------------------------------------------
  // Neutral Palette
  // ---------------------------------------------------------------------------

  /// Pure white — page backgrounds and card surfaces.
  static const Color background = Color(0xFFFFFFFF);

  /// Card / surface colour.
  static const Color surface = Color(0xFFFFFFFF);

  /// Subtle card border colour.
  static const Color border = Color(0xFFE0E0E0);

  /// Divider / separator lines.
  static const Color divider = Color(0xFFEEEEEE);

  // ---------------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------------

  /// Primary text — headings and body.
  static const Color textPrimary = Color(0xFF1A1A1A);

  /// Secondary text — subtitles and captions.
  static const Color textSecondary = Color(0xFF757575);

  /// Hint / placeholder text.
  static const Color textHint = Color(0xFFBDBDBD);

  /// White text — used on maroon backgrounds.
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Semantic / Status
  // ---------------------------------------------------------------------------

  /// Success green — checkmark on calibration complete screen.
  static const Color success = Color(0xFF4CAF50);

  /// High-risk / critical severity.
  static const Color severityHigh = Color(0xFFD32F2F);

  /// Medium-risk severity.
  static const Color severityMedium = Color(0xFFFFA000);

  /// Low-risk severity.
  static const Color severityLow = Color(0xFF388E3C);

  // ---------------------------------------------------------------------------
  // Miscellaneous
  // ---------------------------------------------------------------------------

  /// Icon tint for inactive nav items.
  static const Color iconInactive = Color(0xFF9E9E9E);

  /// Scaffold background — very subtle off-white for depth.
  static const Color scaffoldBackground = Color(0xFFF9F9F9);
}
