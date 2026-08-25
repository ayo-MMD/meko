import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_button.dart';

/// Success / Calibration Complete page — shown after a successful
/// Vgate BLE connection. Displays a large checkmark, the paired
/// vehicle name, and a Continue button to the Home dashboard.
class SuccessCalibrationPage extends StatelessWidget {
  const SuccessCalibrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Receive vehicle name from route arguments or state
    const vehicleName = '2013 Toyota Avalon';

    return Scaffold(
      backgroundColor: MekoColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // --- "All set!" ---
              Text(
                'All set!',
                style: MekoTextStyles.headlineLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // --- Checkmark Circle ---
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  color: MekoColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 80,
                  color: MekoColors.textOnPrimary,
                ),
              ),

              const SizedBox(height: 40),

              // --- Vehicle Info ---
              Text(
                'Your',
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                vehicleName,
                style: MekoTextStyles.headlineSmall.copyWith(
                  color: MekoColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'is now being scanned for faults',
                style: MekoTextStyles.bodyMedium.copyWith(
                  color: MekoColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              // --- Continue Button ---
              MekoButton(
                label: 'Continue',
                onPressed: () {
                  // Navigate to main app and clear the onboarding stack
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home',
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
