/// Typed access to environment variables loaded from `.env`.
///
/// Keys match the variables defined in project configuration.
/// Uses `flutter_dotenv` at runtime via `dotenv.env[key]`.
class EnvConfig {
  EnvConfig._();

  // --- Supabase ---
  static const String supabaseUrl = 'SUPABASE_URL';
  static const String supabasePubKey = 'SUPABASE_PUB_KEY';
  static const String supabaseAnonKey = 'SUPABASE_ANON_KEY';
  static const String supabaseSecretKey = 'SUPABASE_SECRET_KEY';

  // --- Make.com Webhook ---
  static const String makeWebhookUrl = 'MAKE_WEBHOOK_URL';
}
