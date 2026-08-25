import 'package:flutter/material.dart';

import '../../services/bluetooth_service.dart';
import '../../services/error_log_service.dart';
import '../../ui/theme/meko_colors.dart';
import '../../ui/theme/meko_text_styles.dart';
import '../../ui/widgets/meko_button.dart';

/// Bluetooth Handshake screen — connects to the Vgate adapter via BLE.
///
/// Implements the full handshake flow from SKILL.md §6:
/// - Request permissions
/// - Wait 1000ms buffer delay
/// - Execute connectToVgateAdapter
/// - On success: show status indicators and enable Continue
/// - On failure: AlertDialog with Retry (NO auto-navigate, SKILL.md §6)
class BluetoothHandshakePage extends StatefulWidget {
  const BluetoothHandshakePage({super.key});

  @override
  State<BluetoothHandshakePage> createState() => _BluetoothHandshakePageState();
}

enum _HandshakeStatus { idle, connecting, success, failed }

class _BluetoothHandshakePageState extends State<BluetoothHandshakePage> {
  _HandshakeStatus _status = _HandshakeStatus.idle;

  // Step statuses for the three indicator rows
  bool _permissionsGranted = false;
  bool _deviceFound = false;
  bool _connectionEstablished = false;

  @override
  void initState() {
    super.initState();
    _startHandshake();
  }

  /// Full handshake flow per SKILL.md §6.
  Future<void> _startHandshake() async {
    setState(() {
      _status = _HandshakeStatus.connecting;
      _permissionsGranted = false;
      _deviceFound = false;
      _connectionEstablished = false;
    });

    try {
      // Step 1: Request permissions (static method)
      final permResult = await BluetoothService.requestPermissions();
      if (!mounted) return;
      setState(() => _permissionsGranted = permResult);

      if (!permResult) {
        _onFailure('Bluetooth permissions denied');
        return;
      }

      // Step 2: Connect (includes 1000ms buffer delay, scan, and connect)
      final btSuccess = await BluetoothService.connectToVgateAdapter();
      if (!mounted) return;

      if (btSuccess) {
        setState(() {
          _deviceFound = true;
          _connectionEstablished = true;
          _status = _HandshakeStatus.success;
        });
      } else {
        setState(() {
          _deviceFound = false;
          _connectionEstablished = false;
        });
        _onFailure('Could not connect to Vgate adapter');
      }
    } catch (e) {
      if (!mounted) return;
      await ErrorLogService.log('BluetoothHandshake', e);
      _onFailure('Unexpected error: $e');
    }
  }

  /// SKILL.md §6 — Display Alert Dialog but DO NOT navigate away.
  void _onFailure(String message) {
    if (!mounted) return;
    setState(() => _status = _HandshakeStatus.failed);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Connection Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _startHandshake(); // Retry
            },
            child: const Text('Retry Connection'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isConnecting = _status == _HandshakeStatus.connecting;
    final isSuccess = _status == _HandshakeStatus.success;

    return Scaffold(
      backgroundColor: MekoColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // --- Bluetooth Icon ---
              Icon(
                Icons.bluetooth,
                size: 120,
                color: MekoColors.primary
                    .withValues(alpha: isConnecting ? 0.6 : 1.0),
              ),

              const SizedBox(height: 32),

              // --- Title ---
              Text(
                'Connecting to Vgate pro',
                style: MekoTextStyles.headlineMedium.copyWith(
                  color: MekoColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Establishing a secure datalink with vehicle ECU',
                style: MekoTextStyles.bodyMedium.copyWith(
                  color: MekoColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // --- Status Indicators ---
              _StatusRow(
                label: 'Bluetooth permissions',
                isComplete: _permissionsGranted,
                isActive: isConnecting && !_permissionsGranted,
              ),
              const SizedBox(height: 8),
              _StatusRow(
                label: 'Device discovered',
                isComplete: _deviceFound,
                isActive: isConnecting && _permissionsGranted && !_deviceFound,
              ),
              const SizedBox(height: 8),
              _StatusRow(
                label: 'Connection established',
                isComplete: _connectionEstablished,
                isActive:
                    isConnecting && _deviceFound && !_connectionEstablished,
              ),

              const Spacer(flex: 3),

              // --- Continue / Loading ---
              if (isConnecting)
                const Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: CircularProgressIndicator(
                    color: MekoColors.primary,
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: MekoButton(
                    label: 'Continue',
                    onPressed: isSuccess
                        ? () => Navigator.of(context)
                            .pushNamed('/successCalibrationComplete')
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single status indicator row (checkmark or arrow with label).
class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.isComplete,
    required this.isActive,
  });

  final String label;
  final bool isComplete;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color iconColor;

    if (isComplete) {
      icon = Icons.check_circle;
      iconColor = MekoColors.primary;
    } else if (isActive) {
      icon = Icons.arrow_forward;
      iconColor = MekoColors.textSecondary;
    } else {
      icon = Icons.radio_button_unchecked;
      iconColor = MekoColors.textHint;
    }

    return Row(
      children: [
        Icon(icon, size: 22, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: MekoTextStyles.bodyMedium.copyWith(
              color: isComplete
                  ? MekoColors.textPrimary
                  : MekoColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
