/// Typed access to environment variables loaded from `.env`.
///
/// Keys match the variables defined in SKILL.md §3.
/// Uses `flutter_dotenv` at runtime via `dotenv.env[key]`.
class EnvConfig {
  EnvConfig._();

  // --- Supabase ---
  static const String supabaseUrl = 'SUPABASE_URL';
  static const String supabaseAnonKey = 'SUPABASE_ANON_KEY';

  // --- Make.com Webhook ---
  static const String makeWebhookUrl = 'MAKE_WEBHOOK_URL';
}
