import 'enums.dart';

/// Data model for the `mechanic_settings` table.
///
/// Stores branding (logo, colors) and billing configuration
/// for a mechanic's practice.
class MechanicSettings {
  const MechanicSettings({
    required this.id,
    required this.logo,
    required this.billingType,
    required this.frequency,
    required this.charge,
    required this.mechanicId,
    this.createdAt,
    this.primaryColor,
    this.secondaryColor,
    this.metadata,
  });

  final String id;
  final DateTime? createdAt;
  final String logo;
  final String? primaryColor;
  final String? secondaryColor;
  final BillingType billingType;
  final Frequency frequency;
  final double charge;
  final String mechanicId;
  final Map<String, dynamic>? metadata;

  factory MechanicSettings.fromJson(Map<String, dynamic> json) {
    return MechanicSettings(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      logo: json['logo'] as String? ?? '',
      primaryColor: json['primary_color'] as String?,
      secondaryColor: json['secondary_color'] as String?,
      billingType: BillingType.fromString(json['billing_type'] as String?),
      frequency: Frequency.fromString(json['frequency'] as String?),
      charge: (json['charge'] as num?)?.toDouble() ?? 0,
      mechanicId: json['mechanic_id'] as String? ?? '',
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'logo': logo,
        'primary_color': primaryColor,
        'secondary_color': secondaryColor,
        'billing_type': billingType.toJson,
        'frequency': frequency.toJson,
        'charge': charge,
        'mechanic_id': mechanicId,
        'metadata': metadata,
      };
}
