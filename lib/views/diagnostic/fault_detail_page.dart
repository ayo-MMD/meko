import 'package:flutter/material.dart';

import '../../models/fault.dart';
import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_app_bar.dart';

/// Fault Detail page — shows full information for a single diagnostic fault.
///
/// Layout matches the mockup: fault code heading, severity icon with label,
/// description section, numbered symptoms list, numbered consequences list.
class FaultDetailPage extends StatelessWidget {
  const FaultDetailPage({super.key, required this.fault});

  final Fault fault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MekoColors.background,
      appBar: const MekoAppBar(title: 'Diagnostic fault'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Fault Code + Name ---
            Text(
              '${fault.code}-  ${fault.name.toUpperCase()}',
              style: MekoTextStyles.headlineMedium.copyWith(
                color: MekoColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // --- Severity Icon ---
            Icon(
              _severityIcon(fault.severity),
              size: 72,
              color: _severityColor(fault.severity),
            ),
            const SizedBox(height: 8),
            Text(
              fault.severity.label,
              style: MekoTextStyles.label.copyWith(
                color: _severityColor(fault.severity),
              ),
            ),

            const SizedBox(height: 32),

            // --- Description ---
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: MekoTextStyles.headlineSmall.copyWith(
                  color: MekoColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                fault.description.isNotEmpty ? fault.description : 'Description',
                style: MekoTextStyles.bodyLarge.copyWith(
                  color: MekoColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Symptoms ---
            if (fault.symptoms.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Symptoms',
                  style: MekoTextStyles.headlineSmall.copyWith(
                    color: MekoColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'This may cause your car to experience any of the following:',
                  style: MekoTextStyles.bodyMedium.copyWith(
                    color: MekoColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...fault.symptoms.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${entry.key + 1}. ${entry.value}',
                          style: MekoTextStyles.bodyMedium.copyWith(
                            color: MekoColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 24),
            ],

            // --- Consequences ---
            if (fault.consequences.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Consequences',
                  style: MekoTextStyles.headlineSmall.copyWith(
                    color: MekoColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'If not fixed immediately, it could lead to more damages like:',
                  style: MekoTextStyles.bodyMedium.copyWith(
                    color: MekoColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...fault.consequences.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${entry.key + 1}. ${entry.value}',
                          style: MekoTextStyles.bodyMedium.copyWith(
                            color: MekoColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _severityIcon(FaultSeverity sev) {
    switch (sev) {
      case FaultSeverity.high:
        return Icons.warning_rounded;
      case FaultSeverity.medium:
        return Icons.warning_amber_rounded;
      case FaultSeverity.low:
        return Icons.info_outline;
    }
  }

  Color _severityColor(FaultSeverity sev) {
    switch (sev) {
      case FaultSeverity.high:
        return MekoColors.severityHigh;
      case FaultSeverity.medium:
        return MekoColors.severityMedium;
      case FaultSeverity.low:
        return MekoColors.severityLow;
    }
  }
}
