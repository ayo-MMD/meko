import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';

/// Home Page dashboard — shows fault summary, fuel efficiency, and garage info.
///
/// This is the primary landing page after onboarding, sitting inside
/// the MainShell bottom navigation wrapper.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data from Supabase
    const totalFaults = 4;
    const highRiskFaults = 2;
    const midRiskFaults = 2;
    const averageMpg = '30';
    const garageName = 'Ratcliff Autos';
    const garageAddress = '8-10 Sydenam close,\nSE27 5ZU';

    return Scaffold(
      backgroundColor: MekoColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // --- Warning Icon + Fault Count ---
              Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: MekoColors.textPrimary.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$totalFaults ',
                      style: MekoTextStyles.headlineLarge.copyWith(
                        color: MekoColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: 'Error codes found',
                      style: MekoTextStyles.bodyLarge.copyWith(
                        color: MekoColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- High / Mid Risk Cards ---
              const Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '$highRiskFaults',
                      label: 'High-risk\nFaults',
                      borderColor: MekoColors.severityHigh,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      value: '$midRiskFaults',
                      label: 'Mid-risk\nFaults',
                      borderColor: MekoColors.severityMedium,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // --- Fuel Efficiency Section ---
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Keep track of your fuel efficiency',
                  style: MekoTextStyles.headlineSmall.copyWith(
                    color: MekoColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Fuel card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MekoColors.border),
                ),
                child: Row(
                  children: [
                    // Fuel icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: MekoColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.local_gas_station,
                        color: MekoColors.textPrimary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tue, May 5 2025',
                            style: MekoTextStyles.bodyMedium.copyWith(
                              color: MekoColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Average of ',
                                style: MekoTextStyles.bodySmall.copyWith(
                                  color: MekoColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$averageMpg MPG',
                            style: MekoTextStyles.statLarge.copyWith(
                              color: MekoColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // History chevron
                    Column(
                      children: [
                        Text(
                          'History',
                          style: MekoTextStyles.bodySmall.copyWith(
                            color: MekoColors.textSecondary,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: MekoColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Garage Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MekoColors.border),
                ),
                child: Row(
                  children: [
                    // Garage icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: MekoColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.store_outlined,
                        color: MekoColors.textPrimary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            garageName,
                            style: MekoTextStyles.bodyMedium.copyWith(
                              color: MekoColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            garageAddress,
                            style: MekoTextStyles.bodySmall.copyWith(
                              color: MekoColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: MekoColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A bordered stat card showing a large number and a label.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.borderColor,
  });

  final String value;
  final String label;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MekoColors.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: MekoTextStyles.statLarge.copyWith(
              color: MekoColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: MekoTextStyles.bodySmall.copyWith(
              color: MekoColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
