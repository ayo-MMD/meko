import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_option_card.dart';

/// Connect Vehicle screen — lets the user choose between
/// Vgate Bluetooth Adapter or Smartcar Cloud Sync.
class ConnectVehiclePage extends StatelessWidget {
  const ConnectVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MekoColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // --- Heading ---
              Text(
                'Connect Your Vehicle',
                style: MekoTextStyles.headlineLarge.copyWith(
                  color: MekoColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Select how the app will read your vehicle's\ndiagnostic data",
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // --- Option 1: Vgate Bluetooth Adapter ---
              MekoOptionCard(
                icon: Icons.bluetooth,
                title: 'Vgate Bluetooth Adapter',
                subtitle:
                    'Read code via the device provided to you by your garage',
                onTap: () {
                  Navigator.of(context).pushNamed('/vgateSetupInitializing');
                },
              ),

              const SizedBox(height: 20),

              // --- Option 2: Smartcar Cloud Sync ---
              MekoOptionCard(
                icon: Icons.cloud_sync_outlined,
                title: 'Smartcar Cloud Sync',
                subtitle:
                    'Link via your connected manufacturer account using the internet. (You will need an account with your car manufacturer)',
                onTap: () {
                  Navigator.of(context).pushNamed('/smartcarPath');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
