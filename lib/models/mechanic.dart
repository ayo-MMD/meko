/// Data model for the `mechanic` table.
///
/// A mechanic is linked to a [user] record via [userId] and is identified
/// by customers through their unique [referralId].
class Mechanic {
  const Mechanic({
    required this.id,
    required this.userId,
    required this.referralId,
    this.createdAt,
  });

  final String id;
  final DateTime? createdAt;
  final String userId;
  final String referralId;

  factory Mechanic.fromJson(Map<String, dynamic> json) {
    return Mechanic(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      userId: json['user_id'] as String? ?? '',
      referralId: json['referral_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'referral_id': referralId,
      };
}
