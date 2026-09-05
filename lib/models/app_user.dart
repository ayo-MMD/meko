import 'customer.dart';
import 'enums.dart';
import 'vehicle.dart';

/// Data model for the `user` table.
///
/// Named `AppUser` to avoid collision with Dart's built-in `User` type.
/// Can optionally carry joined [customer] and [vehicles] data when
/// fetched via PostgREST relationships (`select=*,customer(*),vehicle(*)`).
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
    this.customer,
    this.vehicles = const [],
  });

  final String id;
  final DateTime? createdAt;
  final String email;
  final String? phoneNumber;
  final String password;
  final String fullname;
  final String? address;
  final ProfileStatus status;
  final Customer? customer;
  final List<Vehicle> vehicles;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    Customer? customer;
    if (json['customer'] is Map<String, dynamic>) {
      customer = Customer.fromJson(json['customer'] as Map<String, dynamic>);
    } else if (json['customer'] is List &&
        (json['customer'] as List).isNotEmpty) {
      final first = (json['customer'] as List).first;
      if (first is Map<String, dynamic>) {
        customer = Customer.fromJson(first);
      }
    }

    List<Vehicle> vehicles = const [];
    if (json['vehicle'] is List) {
      vehicles = (json['vehicle'] as List)
          .whereType<Map<String, dynamic>>()
          .map(Vehicle.fromJson)
          .toList();
    }

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
      customer: customer,
      vehicles: vehicles,
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
        if (customer != null) 'customer': customer!.toJson(),
        if (vehicles.isNotEmpty)
          'vehicle': vehicles.map((v) => v.toJson()).toList(),
      };
}
