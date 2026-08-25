import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/env_config.dart';

/// Singleton wrapper around the Supabase client.
///
/// Initialised once at app startup via [init]. Provides a typed
/// accessor to the underlying [SupabaseClient] used throughout
/// the services layer.
class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  /// Initialise the Supabase SDK with credentials from `.env`.
  ///
  /// Must be called in `main()` before `runApp`.
  static Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env[EnvConfig.supabaseUrl]!,
      publishableKey: dotenv.env[EnvConfig.supabaseAnonKey]!,
    );
  }
}
