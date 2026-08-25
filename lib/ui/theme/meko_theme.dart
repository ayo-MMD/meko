/// Application theme definitions for Meko.
///
/// Centralizes color palettes, text styles, and component themes.
/// Import this file to access `MekoTheme.light` or `MekoTheme.dark`.
library;

import 'package:flutter/material.dart';

import 'meko_colors.dart';
import 'meko_text_styles.dart';

class MekoTheme {
  MekoTheme._();

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MekoColors.primary,
          brightness: Brightness.light,
          primary: MekoColors.primary,
          onPrimary: MekoColors.textOnPrimary,
          surface: MekoColors.surface,
          onSurface: MekoColors.textPrimary,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: MekoColors.scaffoldBackground,

        // --- AppBar ---
        appBarTheme: const AppBarTheme(
          backgroundColor: MekoColors.primary,
          foregroundColor: MekoColors.textOnPrimary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: MekoColors.textOnPrimary,
          ),
          iconTheme: IconThemeData(color: MekoColors.textOnPrimary),
        ),

        // --- Elevated Button (primary CTA) ---
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: MekoColors.primary,
            foregroundColor: MekoColors.textOnPrimary,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: MekoTextStyles.button,
            elevation: 0,
          ),
        ),

        // --- Text Button ---
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: MekoColors.primary,
            textStyle: MekoTextStyles.button,
          ),
        ),

        // --- Input Decoration ---
        inputDecorationTheme: InputDecorationTheme(
          filled: false,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MekoColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MekoColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MekoColors.primary, width: 1.5),
          ),
          hintStyle: MekoTextStyles.bodyMedium.copyWith(
            color: MekoColors.textHint,
          ),
        ),

        // --- Bottom Nav ---
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: MekoColors.surface,
          selectedItemColor: MekoColors.primary,
          unselectedItemColor: MekoColors.iconInactive,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: MekoTextStyles.navLabel,
          unselectedLabelStyle: MekoTextStyles.navLabel,
          showUnselectedLabels: true,
        ),

        // --- Card ---
        cardTheme: CardThemeData(
          color: MekoColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: MekoColors.border),
          ),
          margin: EdgeInsets.zero,
        ),

        // --- Divider ---
        dividerTheme: const DividerThemeData(
          color: MekoColors.divider,
          thickness: 1,
          space: 0,
        ),
      );

  static ThemeData get dark => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MekoColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );
}
