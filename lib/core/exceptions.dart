/// Application-wide custom exceptions and error types.
///
/// Feature-specific exceptions (e.g., BLE, Supabase) can extend
/// [MekoException] to enable uniform error handling.
class MekoException implements Exception {
  const MekoException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'MekoException($code): $message';
}
