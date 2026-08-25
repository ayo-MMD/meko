import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_app_bar.dart';

/// Settings page — vehicle info, sync status, reset, and sign out.
///
/// Layout from the mockup: maroon AppBar, vehicle image, vehicle name + VIN,
/// last synced label, "Reset Data & Change cars", "Sign out".
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data
    const vehicleName = '2013 Toyota Avalon';
    const vehicleVin = '4T1BK1EB1DU012345';
    const lastSynced = 'Last synced:2 minutes ago';

    return Scaffold(
      backgroundColor: MekoColors.background,
      appBar: const MekoAppBar(title: 'Settings', showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // --- Vehicle Image ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                height: 200,
                color: MekoColors.textPrimary.withValues(alpha: 0.08),
                child: const Icon(
                  Icons.directions_car,
                  size: 80,
                  color: MekoColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Vehicle Name ---
            Text(
              vehicleName,
              style: MekoTextStyles.headlineSmall.copyWith(
                color: MekoColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // --- VIN ---
            Text(
              vehicleVin,
              style: MekoTextStyles.bodyMedium.copyWith(
                color: MekoColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // --- Last Synced ---
            Text(
              lastSynced,
              style: MekoTextStyles.bodySmall.copyWith(
                color: MekoColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // --- Reset Data & Change cars ---
            _SettingsOption(
              label: 'Reset Data & Change cars',
              onTap: () {
                // TODO: Clear local data and navigate to onboarding
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset Data'),
                    content: const Text(
                        'This will clear all vehicle data and return to setup. Continue?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/authenticationPage',
                            (route) => false,
                          );
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            // --- Sign Out ---
            _SettingsOption(
              label: 'Sign out',
              onTap: () {
                // TODO: Sign out from Supabase
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/authenticationPage',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A tappable settings row matching the mockup style.
class _SettingsOption extends StatelessWidget {
  const _SettingsOption({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: MekoTextStyles.bodyLarge.copyWith(
              color: MekoColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
