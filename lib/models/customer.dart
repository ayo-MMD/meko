/// Data model for the `customer` table.
///
/// A customer belongs to a [mechanic] (via [mechanicId]) and is linked
/// to a [user] account (via [userId]).
class Customer {
  const Customer({
    required this.id,
    required this.mechanicId,
    required this.userId,
    required this.username,
    this.createdAt,
  });

  final String id;
  final DateTime? createdAt;
  final String mechanicId;
  final String userId;
  final String username;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      mechanicId: json['mechanic_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'mechanic_id': mechanicId,
        'user_id': userId,
        'username': username,
      };
}
