import 'package:flutter/material.dart';

import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';

/// Placeholder Appointments page — shown in the bottom nav.
///
/// Full implementation pending additional mockup screenshots for
/// Booking_page and Manage_appointments.
class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MekoColors.background,
      appBar: AppBar(
        backgroundColor: MekoColors.primary,
        foregroundColor: MekoColors.textOnPrimary,
        title: const Text('Appointments'),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: MekoColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No appointments yet',
              style: MekoTextStyles.headlineSmall.copyWith(
                color: MekoColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your scheduled bookings will appear here',
              style: MekoTextStyles.bodyMedium.copyWith(
                color: MekoColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
