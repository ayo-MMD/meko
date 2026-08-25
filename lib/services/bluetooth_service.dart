import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/constants.dart';
import 'error_log_service.dart';

/// BLE service for connecting to the Vgate iCar Pro OBD2 adapter.
///
/// Implements all constraints from SKILL.md §5:
/// - Dual-mode filtering (only BLE "IOS-Vlink", never Classic "Android-Vlink")
/// - Case-insensitive name matching
/// - Runtime permission requests with 1000ms OS buffer delay
/// - Scan timeout of 10s, connection timeout of 15s
/// - NEVER passes `license:` to `.connect()`
/// - Devices must NOT be pre-paired in OS settings
class BluetoothService {
  BluetoothService._();

  /// The currently connected Vgate device, if any.
  static BluetoothDevice? _connectedDevice;

  /// Public accessor for the connected device.
  static BluetoothDevice? get connectedDevice => _connectedDevice;

  // ---------------------------------------------------------------------------
  // Permissions
  // ---------------------------------------------------------------------------

  /// Request all BLE-related runtime permissions.
  ///
  /// On Android, requests Bluetooth Scan, Connect, and Location.
  /// Returns `true` if all required permissions are granted.
  static Future<bool> requestPermissions() async {
    try {
      if (Platform.isAndroid) {
        final statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.locationWhenInUse,
        ].request();

        return statuses.values.every(
          (s) => s.isGranted || s.isLimited,
        );
      }

      // iOS handles BLE permissions via Info.plist; no runtime request needed.
      return true;
    } catch (e) {
      await ErrorLogService.log('BluetoothService.requestPermissions', e);
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Connection Flow (SKILL.md §5 + §6)
  // ---------------------------------------------------------------------------

  /// Execute the full Vgate adapter handshake.
  ///
  /// 1. Request permissions
  /// 2. Wait 1000ms OS buffer delay
  /// 3. Scan for BLE device matching Vgate filter
  /// 4. Connect with 15s timeout
  ///
  /// Returns `true` (`btSuccess`) if connection succeeds, `false` otherwise.
  static Future<bool> connectToVgateAdapter() async {
    try {
      // Step 1: Runtime permissions
      final permissionsGranted = await requestPermissions();
      if (!permissionsGranted) return false;

      // Step 2: OS Buffer Delay (SKILL.md §5)
      await Future<void>.delayed(AppConstants.blePermissionBufferDelay);

      // Step 3: Scan for the Vgate BLE adapter
      BluetoothDevice? targetDevice;
      bool deviceFound = false;

      await FlutterBluePlus.startScan(
        timeout: AppConstants.bleScanTimeout,
      );

      await for (final results in FlutterBluePlus.scanResults) {
        for (final r in results) {
          // Case-insensitive filtering (SKILL.md §5)
          final String name = r.device.platformName.toLowerCase();
          final String advName = r.advertisementData.advName.toLowerCase();

          // Target BLE signals, strictly ignore Classic Bluetooth
          if ((name.contains('vgate') ||
                  advName.contains('vgate') ||
                  name.contains('ios-vlink') ||
                  advName.contains('ios-vlink')) &&
              !name.contains('android') &&
              !advName.contains('android')) {
            targetDevice = r.device;
            deviceFound = true;
            await FlutterBluePlus.stopScan();
            break;
          }
        }
        if (deviceFound) break;
      }

      if (targetDevice == null) return false;

      // Step 4: Connect — NEVER pass `license:` (SKILL.md §5)
      await targetDevice.connect(
        timeout: AppConstants.bleConnectionTimeout,
      );

      _connectedDevice = targetDevice;
      return true;
    } catch (e) {
      await ErrorLogService.log('BluetoothService.connectToVgateAdapter', e);
      return false;
    }
  }

  /// Disconnect from the current device, if connected.
  static Future<void> disconnect() async {
    try {
      await _connectedDevice?.disconnect();
      _connectedDevice = null;
    } catch (e) {
      await ErrorLogService.log('BluetoothService.disconnect', e);
    }
  }
}
