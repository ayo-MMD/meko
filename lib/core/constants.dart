/// Application-wide constants for Meko.
///
/// Centralises magic strings, durations, and BLE configuration values
/// derived from the SKILL.md technical specification.
class AppConstants {
  AppConstants._();

  static const String appName = 'Meko';
  static const String appVersion = '0.1.0';

  // ---------------------------------------------------------------------------
  // BLE Constants (SKILL.md §5)
  // ---------------------------------------------------------------------------

  /// Scan timeout before giving up on finding the Vgate adapter.
  static const Duration bleScanTimeout = Duration(seconds: 10);

  /// Connection timeout after a target device is found.
  static const Duration bleConnectionTimeout = Duration(seconds: 15);

  /// Mandatory delay after permission approval to let the native OS
  /// Bluetooth stack initialise (SKILL.md §5 — OS Buffer Delay).
  static const Duration blePermissionBufferDelay = Duration(milliseconds: 1000);

  // ---------------------------------------------------------------------------
  // Supabase Tables (SKILL.md §4)
  // ---------------------------------------------------------------------------

  /// Remote error logging table.
  static const String tableErrorLogs = 'error_logs';
}
