import 'package:flutter/material.dart';

import '../theme/meko_colors.dart';
import '../theme/meko_text_styles.dart';

/// Bordered option card with icon area, title, subtitle, and trailing chevron.
///
/// Used on the "Connect Your Vehicle" page for the Vgate and Smartcar options.
class MekoOptionCard extends StatelessWidget {
  const MekoOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.icon,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MekoColors.border),
        ),
        child: Row(
          children: [
            // Icon area
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: MekoColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon ?? Icons.bluetooth,
                color: MekoColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MekoTextStyles.headlineSmall.copyWith(
                      fontSize: 16,
                      color: MekoColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: MekoTextStyles.bodyMedium.copyWith(
                      color: MekoColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Chevron
            const Icon(
              Icons.chevron_right,
              color: MekoColors.textSecondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
