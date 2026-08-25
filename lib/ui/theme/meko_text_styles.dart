import 'package:flutter/material.dart';

/// Centralised typography scale for Meko.
///
/// All styles use the system default font (San Francisco on iOS,
/// Roboto on Android) with weights and sizes matched to the mockups.
class MekoTextStyles {
  MekoTextStyles._();

  // ---------------------------------------------------------------------------
  // Headings
  // ---------------------------------------------------------------------------

  /// Large page titles — "Let's go in", "Connect Your Vehicle", "All set!"
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
  );

  /// Section headings — "How it works", "Keep track of your fuel efficiency"
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Card titles — fault codes, vehicle name
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  /// Primary body text — descriptions, explanations.
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Secondary body text — card subtitles, info lines.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  /// Small body text — captions, timestamps.
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // Labels & Buttons
  // ---------------------------------------------------------------------------

  /// Button text — "Proceed", "Continue", "continue".
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  /// Tab labels — "High", "Medium", "Low".
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// Bottom nav labels.
  static const TextStyle navLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // ---------------------------------------------------------------------------
  // Special
  // ---------------------------------------------------------------------------

  /// AppBar title — white text on maroon background.
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// Large stat numbers — "30 MPG", fault counts.
  static const TextStyle statLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
}
