import 'package:flutter/material.dart';

import '../ui/theme/meko_colors.dart';
import '../ui/theme/meko_text_styles.dart';
import 'bookings/appointments_page.dart';
import 'diagnostic/fault_list_page.dart';
import 'home/home_page.dart';
import 'settings/settings_page.dart';

/// Main navigation shell — wraps the 4 bottom-nav tabs.
///
/// Tabs: Home, Fault list, Appointments, Settings.
/// Each tab maintains its own widget so state is preserved when switching.
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  /// Which tab to show initially (0 = Home, 1 = Fault list, etc.)
  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomePage(),
    FaultListPage(),
    AppointmentsPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: MekoColors.surface,
        selectedItemColor: MekoColors.primary,
        unselectedItemColor: MekoColors.iconInactive,
        selectedLabelStyle: MekoTextStyles.navLabel,
        unselectedLabelStyle: MekoTextStyles.navLabel,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_outlined),
            activeIcon: Icon(Icons.warning_amber_rounded),
            label: 'Fault list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Appointm...',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
