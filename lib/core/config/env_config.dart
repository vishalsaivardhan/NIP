/// Environment configuration for NIP / ProxiUPI
///
/// Supabase and other service credentials are loaded from
/// environment variables at runtime. NEVER hardcode secrets.
class EnvConfig {
  EnvConfig._();

  /// Supabase Project URL — must be configured before backend integration
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  /// Supabase publishable (anon) key — safe for client-side use
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: '',
  );

  /// Whether Supabase is configured
  static bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
