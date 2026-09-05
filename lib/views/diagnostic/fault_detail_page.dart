import 'package:flutter/material.dart';

import '../../models/enums.dart';
import '../../models/notification.dart';
import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_app_bar.dart';

/// Fault Detail page — shows full information for a single DTC notification.
///
/// Layout: fault code heading, severity icon with label, raw code,
/// status, and timestamps.
class FaultDetailPage extends StatelessWidget {
  const FaultDetailPage({super.key, required this.notification});

  final DtcNotification notification;

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
            // --- Fault Code ---
            Text(
              notification.code,
              style: MekoTextStyles.headlineMedium.copyWith(
                color: MekoColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // --- Severity Icon ---
            Icon(
              _severityIcon(notification.severity),
              size: 72,
              color: _severityColor(notification.severity),
            ),
            const SizedBox(height: 8),
            Text(
              notification.severity.label,
              style: MekoTextStyles.label.copyWith(
                color: _severityColor(notification.severity),
              ),
            ),

            const SizedBox(height: 32),

            // --- Status ---
            if (notification.status != null) ...[
              _InfoRow(
                label: 'Status',
                value: notification.status!.label,
              ),
              const SizedBox(height: 16),
            ],

            // --- Raw Code ---
            if (notification.rawCode != null &&
                notification.rawCode!.isNotEmpty) ...[
              _InfoRow(
                label: 'Raw Code',
                value: notification.rawCode!,
              ),
              const SizedBox(height: 16),
            ],

            // --- Created At ---
            if (notification.createdAt != null) ...[
              _InfoRow(
                label: 'Detected',
                value: _formatDateTime(notification.createdAt!),
              ),
              const SizedBox(height: 16),
            ],

            // --- Resolved At ---
            if (notification.resolvedAt != null) ...[
              _InfoRow(
                label: 'Resolved',
                value: _formatDateTime(notification.resolvedAt!),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  IconData _severityIcon(NotificationSeverity sev) {
    switch (sev) {
      case NotificationSeverity.high:
        return Icons.warning_rounded;
      case NotificationSeverity.medium:
        return Icons.warning_amber_rounded;
      case NotificationSeverity.low:
        return Icons.info_outline;
    }
  }

  Color _severityColor(NotificationSeverity sev) {
    switch (sev) {
      case NotificationSeverity.high:
        return MekoColors.severityHigh;
      case NotificationSeverity.medium:
        return MekoColors.severityMedium;
      case NotificationSeverity.low:
        return MekoColors.severityLow;
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} at ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

/// A labelled info row used in the detail view.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: MekoTextStyles.headlineSmall.copyWith(
              color: MekoColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: MekoTextStyles.bodyLarge.copyWith(
              color: MekoColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
