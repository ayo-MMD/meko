import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/env_config.dart';
import '../models/app_user.dart';

/// Response payload from `verify_and_activate_customer` RPC.
class VerificationResult {
  const VerificationResult({
    required this.success,
    this.userEmail,
    this.message,
  });

  final bool success;
  final String? userEmail;
  final String? message;

  factory VerificationResult.fromList(List<dynamic> list) {
    if (list.isEmpty) {
      return const VerificationResult(
        success: false,
        message: 'No response received from verification server.',
      );
    }
    final item = list.first;
    if (item is Map<String, dynamic>) {
      return VerificationResult(
        success: item['success'] == true,
        userEmail: item['user_email'] as String?,
        message: item['message'] as String?,
      );
    }
    return const VerificationResult(
      success: false,
      message: 'Unexpected response format from server.',
    );
  }

  factory VerificationResult.fromMap(Map<String, dynamic> map) {
    return VerificationResult(
      success: map['success'] == true,
      userEmail: map['user_email'] as String?,
      message: map['message'] as String?,
    );
  }
}

/// Singleton wrapper around Supabase clients and helper operations.
class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  /// Secret / Service-role client for privileged endpoints.
  /// Falls back to [client] if secret key is not provided.
  static late SupabaseClient adminClient;

  /// Cached active user session state.
  static AppUser? currentUser;

  /// Initialise Supabase SDK with credentials from `.env`.
  /// Must be called in `main()` before `runApp`.
  static Future<void> init() async {
    final url = dotenv.env[EnvConfig.supabaseUrl] ?? '';
    final pubKey = dotenv.env[EnvConfig.supabasePubKey] ?? '';
    final anonKey = dotenv.env[EnvConfig.supabaseAnonKey] ?? '';
    final secretKey = dotenv.env[EnvConfig.supabaseSecretKey] ?? '';

    // Primary client initialized with SUPABASE_PUB_KEY and Content-Type
    await Supabase.initialize(
      url: url,
      publishableKey: pubKey,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Privileged client with apikey = SUPABASE_SECRET_KEY & Authorization = Bearer SUPABASE_ANON_KEY
    adminClient = SupabaseClient(
      url,
      secretKey.isNotEmpty ? secretKey : pubKey,
      headers: {
        'Content-Type': 'application/json',
        if (secretKey.isNotEmpty) 'apikey': secretKey,
        if (anonKey.isNotEmpty) 'Authorization': 'Bearer $anonKey',
      },
    );
  }

  /// Calls `rpc/verify_and_activate_customer` with the provided garage ID and username.
  static Future<VerificationResult> verifyAndActivateCustomer({
    required String garageId,
    required String customerUsername,
  }) async {
    try {
      final response = await client.rpc(
        'verify_and_activate_customer',
        params: {
          'p_garage_id': garageId,
          'p_customer_username': customerUsername,
        },
      );

      if (response is List) {
        return VerificationResult.fromList(response);
      } else if (response is Map<String, dynamic>) {
        return VerificationResult.fromMap(response);
      }

      return VerificationResult(
        success: response == true,
        message: response?.toString(),
      );
    } catch (e) {
      debugPrint('Error calling verify_and_activate_customer: $e');
      return VerificationResult(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// Fetches a user record joined with customer and vehicle data (`*, customer(*), vehicle(*)`).
  ///
  /// Uses [adminClient] to satisfy elevated API key requirements.
  static Future<AppUser?> getUserWithRelations({
    String? userId,
    String? email,
  }) async {
    try {
      final query = adminClient.from('user').select('*, customer(*), vehicle(*)');

      final dynamic response;
      if (userId != null && userId.isNotEmpty) {
        response = await query.eq('id', userId).maybeSingle();
      } else if (email != null && email.isNotEmpty) {
        response = await query.eq('email', email).maybeSingle();
      } else {
        return null;
      }

      if (response != null && response is Map<String, dynamic>) {
        final user = AppUser.fromJson(response);
        currentUser = user;
        return user;
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user with relations: $e');
      return null;
    }
  }
}
