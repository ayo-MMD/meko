import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants.dart';

/// Centralised error logger that writes to the Supabase `error_logs` table.
///
/// Implements the Critical Exception Logging Rule from SKILL.md §4:
/// every `catch` block across services MUST call [log] to persist
/// the error remotely without crashing the app.
class ErrorLogService {
  ErrorLogService._();

  static final _client = Supabase.instance.client;

  /// Persist an error message to the `error_logs` table.
  ///
  /// Fails silently if the network is unavailable, as required by
  /// the spec. The [context] parameter should identify the calling
  /// method (e.g., `'BluetoothService.connectToVgateAdapter'`).
  static Future<void> log(String context, Object error) async {
    // 1. Console print for local debugging
    // ignore: avoid_print
    print('Execution Error [$context]: $error');

    // 2. Isolated Supabase error logging
    try {
      await _client.from(AppConstants.tableErrorLogs).insert({
        'log': '$context failed: ${error.toString()}',
      });
    } catch (_) {
      // Fail silently if network connection is unavailable
    }
  }
}
