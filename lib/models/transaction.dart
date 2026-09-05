import 'enums.dart';

/// Data model for the `transaction` table.
///
/// Records a single financial event — payment, charge, or refund —
/// linked to a [customer], [mechanic], and optionally a [subscription].
class Transaction {
  const Transaction({
    required this.id,
    required this.amount,
    required this.status,
    required this.entry,
    required this.channel,
    this.createdAt,
    this.customerId,
    this.mechanicId,
    this.subscriptionId,
    this.userId,
    this.charge,
    this.metadata,
  });

  final String id;
  final DateTime? createdAt;
  final String? customerId;
  final String? mechanicId;
  final String? subscriptionId;
  final String? userId;
  final double amount;
  final double? charge;
  final Map<String, dynamic>? metadata;
  final TransactionStatus status;
  final TransactionEntry entry;
  final TransactionChannel channel;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      customerId: json['customer_id'] as String?,
      mechanicId: json['mechanic_id'] as String?,
      subscriptionId: json['subscription_id'] as String?,
      userId: json['user_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      charge: (json['charge'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      status: TransactionStatus.fromString(json['status'] as String?),
      entry: TransactionEntry.fromString(json['entry'] as String?),
      channel: TransactionChannel.fromString(json['channel'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'mechanic_id': mechanicId,
        'subscription_id': subscriptionId,
        'user_id': userId,
        'amount': amount,
        'charge': charge,
        'metadata': metadata,
        'status': status.toJson,
        'entry': entry.toJson,
        'channel': channel.toJson,
      };
}
