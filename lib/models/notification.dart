import 'enums.dart';

/// Data model for the `notification` table.
///
/// Named `DtcNotification` to avoid collision with Flutter's built-in
/// [Notification] widget class. Represents an OBD2 diagnostic trouble
/// code (DTC) detected on a vehicle.
class DtcNotification {
  const DtcNotification({
    required this.id,
    required this.vehicleId,
    required this.code,
    required this.severity,
    this.createdAt,
    this.resolvedAt,
    this.status,
    this.rawCode,
  });

  /// UUID primary key.
  final String id;

  final DateTime? createdAt;

  /// FK to the vehicle that reported this code.
  final String vehicleId;

  /// Human-readable or standardised fault code, e.g. "P0230".
  final String code;

  /// Timestamp when the fault was resolved (null = still active).
  final DateTime? resolvedAt;

  /// Severity classification.
  final NotificationSeverity severity;

  /// Current status of this notification.
  final NotificationStatus? status;

  /// Raw OBD2 hex code returned by the ECU.
  final String? rawCode;

  /// Whether this notification is still active (not yet resolved).
  bool get isActive =>
      status == NotificationStatus.active || resolvedAt == null;

  factory DtcNotification.fromJson(Map<String, dynamic> json) {
    return DtcNotification(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      vehicleId: json['vehicle_id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      resolvedAt: json['resolved_at'] != null
          ? DateTime.tryParse(json['resolved_at'] as String)
          : null,
      severity:
          NotificationSeverity.fromString(json['severity'] as String?),
      status: json['status'] != null
          ? NotificationStatus.fromString(json['status'] as String?)
          : null,
      rawCode: json['raw_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'vehicle_id': vehicleId,
        'code': code,
        'resolved_at': resolvedAt?.toIso8601String(),
        'severity': severity.toJson,
        'status': status?.toJson,
        'raw_code': rawCode,
      };
}
