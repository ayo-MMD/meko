/// Data model for the `appointment` table.
///
/// Represents a scheduled service appointment linking a
/// [mechanic], [customer], and [vehicle].
class Appointment {
  const Appointment({
    required this.id,
    required this.scheduledDate,
    required this.mechanicId,
    required this.customerId,
    required this.vehicleId,
    this.createdAt,
  });

  final String id;
  final DateTime? createdAt;
  final DateTime scheduledDate;
  final String mechanicId;
  final String customerId;
  final String vehicleId;

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      scheduledDate: DateTime.parse(json['scheduled_date'] as String),
      mechanicId: json['mechanic_id'] as String? ?? '',
      customerId: json['customer_id'] as String? ?? '',
      vehicleId: json['vehicle_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'scheduled_date': scheduledDate.toIso8601String(),
        'mechanic_id': mechanicId,
        'customer_id': customerId,
        'vehicle_id': vehicleId,
      };
}
