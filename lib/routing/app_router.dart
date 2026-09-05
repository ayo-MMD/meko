import 'package:flutter/material.dart';

import '../models/notification.dart';
import '../views/diagnostic/fault_detail_page.dart';
import '../views/main_shell.dart';
import '../views/onboarding/authentication_page.dart';
import '../views/onboarding/bluetooth_handshake_page.dart';
import '../views/onboarding/connect_vehicle_page.dart';
import '../views/onboarding/smartcar_path_page.dart';
import '../views/onboarding/success_calibration_page.dart';
import '../views/onboarding/vgate_setup_page.dart';

/// Central route definitions for Meko.
///
/// Uses named routes with `onGenerateRoute` for type-safe argument passing.
class AppRouter {
  AppRouter._();

  // Route names ---------------------------------------------------------------

  static const String authenticationPage = '/authenticationPage';
  static const String connectVehicle = '/connectVehicle';
  static const String vgateSetupInitializing = '/vgateSetupInitializing';
  static const String bluetoothHandshake = '/bluetoothHandshake';
  static const String smartcarPath = '/smartcarPath';
  static const String successCalibrationComplete = '/successCalibrationComplete';
  static const String home = '/home';
  static const String fault = '/fault';

  // Initial route -------------------------------------------------------------

  static const String initialRoute = authenticationPage;

  // Route generator -----------------------------------------------------------

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authenticationPage:
        return _page(const AuthenticationPage());

      case connectVehicle:
        return _page(const ConnectVehiclePage());

      case vgateSetupInitializing:
        return _page(const VgateSetupPage());

      case bluetoothHandshake:
        return _page(const BluetoothHandshakePage());

      case smartcarPath:
        return _page(const SmartcarPathPage());

      case successCalibrationComplete:
        return _page(const SuccessCalibrationPage());

      case home:
        return _page(const MainShell());

      case fault:
        final notificationArg = settings.arguments as DtcNotification;
        return _page(FaultDetailPage(notification: notificationArg));

      default:
        return _page(const AuthenticationPage());
    }
  }

  static MaterialPageRoute<dynamic> _page(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
