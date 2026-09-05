import 'package:flutter/material.dart';

import '../../models/enums.dart';
import '../../models/notification.dart';
import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_app_bar.dart';

/// Fault List page — tabbed list of notifications by severity (High, Medium, Low).
///
/// Each card shows the OBD2 code, severity badge, and raw code.
/// Tapping a card navigates to the Fault Detail page.
class FaultListPage extends StatelessWidget {
  const FaultListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: MekoColors.background,
        appBar: const MekoAppBar(title: 'Fault list', showBack: true),
        body: Column(
          children: [
            // --- Severity Tabs ---
            Container(
              color: MekoColors.background,
              child: const TabBar(
                labelColor: MekoColors.severityHigh,
                unselectedLabelColor: MekoColors.textSecondary,
                indicatorColor: MekoColors.primary,
                labelStyle: MekoTextStyles.label,
                unselectedLabelStyle: MekoTextStyles.label,
                tabs: [
                  Tab(
                    icon: Icon(Icons.warning_rounded, size: 22),
                    text: 'High',
                  ),
                  Tab(
                    icon: Icon(Icons.warning_amber_rounded, size: 22),
                    text: 'Medium',
                  ),
                  Tab(
                    icon: Icon(Icons.info_outline, size: 22),
                    text: 'Low',
                  ),
                ],
              ),
            ),

            // --- Notification Lists ---
            const Expanded(
              child: TabBarView(
                children: [
                  _DtcListView(severity: NotificationSeverity.high),
                  _DtcListView(severity: NotificationSeverity.medium),
                  _DtcListView(severity: NotificationSeverity.low),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Scrollable list of DTC notification cards filtered by severity.
class _DtcListView extends StatelessWidget {
  const _DtcListView({required this.severity});

  final NotificationSeverity severity;

  // TODO: Replace with real data from Supabase
  final List<DtcNotification> _demoNotifications = const [
    DtcNotification(
      id: 'demo-1',
      vehicleId: 'v-1',
      code: 'P0320',
      severity: NotificationSeverity.high,
      rawCode: '0320',
    ),
    DtcNotification(
      id: 'demo-2',
      vehicleId: 'v-1',
      code: 'P0230',
      severity: NotificationSeverity.high,
      rawCode: '0230',
    ),
    DtcNotification(
      id: 'demo-3',
      vehicleId: 'v-1',
      code: 'P0455',
      severity: NotificationSeverity.medium,
      rawCode: '0455',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items =
        _demoNotifications.where((n) => n.severity == severity).toList();

    if (items.isEmpty) {
      return Center(
        child: Text(
          'No ${severity.label.toLowerCase()} faults found',
          style: MekoTextStyles.bodyLarge.copyWith(
            color: MekoColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final notification = items[index];
        return _DtcCard(notification: notification);
      },
    );
  }
}

/// A single DTC notification card in the list.
class _DtcCard extends StatelessWidget {
  const _DtcCard({required this.notification});

  final DtcNotification notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/fault', arguments: notification);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MekoColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    notification.code,
                    style: MekoTextStyles.headlineSmall.copyWith(
                      color: MekoColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Severity badge
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 18,
                      color: _severityColor(notification.severity),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notification.severity.label,
                      style: MekoTextStyles.bodySmall.copyWith(
                        color: _severityColor(notification.severity),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (notification.rawCode != null) ...[
              const SizedBox(height: 8),
              Text(
                'Raw code: ${notification.rawCode}',
                style: MekoTextStyles.bodyMedium.copyWith(
                  color: MekoColors.textSecondary,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
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
}
