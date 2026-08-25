import 'package:flutter/material.dart';

import '../../models/fault.dart';
import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_app_bar.dart';

/// Fault List page — tabbed list of faults by severity (High, Medium, Low).
///
/// Each fault card shows the OBD2 code, title, severity badge, and
/// a truncated description. Tapping a card navigates to the Fault Detail page.
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

            // --- Fault Lists ---
            Expanded(
              child: TabBarView(
                children: [
                  _FaultListView(severity: FaultSeverity.high),
                  _FaultListView(severity: FaultSeverity.medium),
                  _FaultListView(severity: FaultSeverity.low),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Scrollable list of fault cards filtered by severity.
class _FaultListView extends StatelessWidget {
  _FaultListView({required this.severity});

  final FaultSeverity severity;

  // TODO: Replace with real data from Supabase
  final List<Fault> _demoFaults = [
    const Fault(
      code: 'P0320',
      name: 'Cylinder misfire',
      severity: FaultSeverity.high,
      description:
          'There appears to be an issue around your fuel pump. This may cause your car to lag when you start to accelerate, it may also cause your car to jerk at high speeds, it may also cause your car to loos.......',
    ),
    const Fault(
      code: 'P0320',
      name: 'Cylinder misfire',
      severity: FaultSeverity.high,
      description:
          'There appears to be an issue around your fuel pump. This may cause your car to lag when you start to accelerate, it may also cause your car to jerk at high speeds, it may also cause your car to loos.......',
    ),
    const Fault(
      code: 'P0320',
      name: 'Cylinder misfire',
      severity: FaultSeverity.high,
      description:
          'There appears to be an issue around your fuel pump. This may cause your car to lag when you start to accelerate, it may also cause your car to jerk at high speeds, it may also cause your car to loos.......',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final faults = _demoFaults.where((f) => f.severity == severity).toList();

    if (faults.isEmpty) {
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
      itemCount: faults.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final fault = faults[index];
        return _FaultCard(fault: fault);
      },
    );
  }
}

/// A single fault card in the list.
class _FaultCard extends StatelessWidget {
  const _FaultCard({required this.fault});

  final Fault fault;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/fault', arguments: fault);
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
                    '${fault.code}: ${fault.name}',
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
                      color: _severityColor(fault.severity),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      fault.severity.label,
                      style: MekoTextStyles.bodySmall.copyWith(
                        color: _severityColor(fault.severity),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              fault.description,
              style: MekoTextStyles.bodyMedium.copyWith(
                color: MekoColors.textSecondary,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
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
