import 'enums.dart';

/// Data model for the `subscription` table.
///
/// Represents a recurring payment agreement between a
/// [customer] and a [mechanic].
class Subscription {
  const Subscription({
    required this.id,
    required this.customerId,
    required this.mechanicId,
    required this.frequency,
    required this.amount,
    this.createdAt,
    this.lastDateActivated,
    this.metadata,
  });

  final String id;
  final DateTime? createdAt;
  final String customerId;
  final String mechanicId;
  final Frequency frequency;
  final double amount;
  final DateTime? lastDateActivated;
  final Map<String, dynamic>? metadata;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      customerId: json['customer_id'] as String? ?? '',
      mechanicId: json['mechanic_id'] as String? ?? '',
      frequency: Frequency.fromString(json['frequency'] as String?),
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      lastDateActivated: json['last_date_activated'] != null
          ? DateTime.tryParse(json['last_date_activated'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'mechanic_id': mechanicId,
        'frequency': frequency.toJson,
        'amount': amount,
        'last_date_activated': lastDateActivated?.toIso8601String(),
        'metadata': metadata,
      };
}
