import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_button.dart';

/// Vgate Setup Initializing page — explains how the adapter works
/// before starting the BLE handshake.
class VgateSetupPage extends StatelessWidget {
  const VgateSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MekoColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // --- Heading ---
              Center(
                child: Text(
                  'Connect  App to\nVgate Bluetooth Adapter',
                  style: MekoTextStyles.headlineLarge.copyWith(
                    color: MekoColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 36),

              // --- How it works ---
              Text(
                'How it works',
                style: MekoTextStyles.headlineMedium.copyWith(
                  color: MekoColors.textPrimary,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'After you connect your device, the Meko app collects data from your car through the Meko OBDII device.',
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'This Data is transmitted to our server in real time for as long as the device is connected with the app.',
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'If an error/ fault  pops up. You will get a notification containing details and analysis of the fault.',
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
              ),

              const Spacer(),

              // --- Continue Button ---
              MekoButton(
                label: 'continue',
                onPressed: () {
                  Navigator.of(context).pushNamed('/bluetoothHandshake');
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
