import 'enums.dart';

/// Data model for the `vehicle` table.
///
/// Represents a vehicle registered by a customer, connected via
/// either a Vgate BLE adapter or Smartcar cloud sync.
class Vehicle {
  const Vehicle({
    required this.id,
    required this.userId,
    required this.customerId,
    this.createdAt,
    this.name,
    this.model,
    this.connectionType = ConnectionType.none,
    this.vin,
  });

  final String id;
  final DateTime? createdAt;
  final String? name;
  final String? model;
  final String userId;
  final ConnectionType connectionType;
  final String customerId;
  final String? vin;

  /// Display name — falls back to model or "Unknown Vehicle".
  String get displayName {
    if (name != null && name!.isNotEmpty) return name!;
    if (model != null && model!.isNotEmpty) return model!;
    return 'Unknown Vehicle';
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      name: json['name'] as String?,
      model: json['model'] as String?,
      userId: json['user_id'] as String? ?? '',
      connectionType:
          ConnectionType.fromString(json['connection_type'] as String?),
      customerId: json['customer_id'] as String? ?? '',
      vin: json['vin'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'model': model,
        'user_id': userId,
        'connection_type': connectionType.toJson,
        'customer_id': customerId,
        'vin': vin,
      };
}
