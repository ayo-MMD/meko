import 'enums.dart';

/// Data model for the `user` table.
///
/// Named `AppUser` to avoid collision with Dart's built-in `User` type.
class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.fullname,
    this.createdAt,
    this.phoneNumber,
    this.password = '',
    this.address,
    this.status = ProfileStatus.inactive,
  });

  final String id;
  final DateTime? createdAt;
  final String email;
  final String? phoneNumber;
  final String password;
  final String fullname;
  final String? address;
  final ProfileStatus status;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      address: json['address'] as String?,
      status: ProfileStatus.fromString(json['status'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'fullname': fullname,
        'address': address,
        'status': status.toJson,
      };
}
