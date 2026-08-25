import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../core/env_config.dart';
import 'error_log_service.dart';

/// Service for dispatching events to Make.com webhooks.
///
/// Uses the `http` package as specified in SKILL.md §2.
class WebhookService {
  WebhookService._();

  /// Send a JSON payload to the configured Make.com webhook URL.
  ///
  /// Returns `true` if the webhook responds with a 2xx status code.
  static Future<bool> dispatch(Map<String, dynamic> payload) async {
    try {
      final url = dotenv.env[EnvConfig.makeWebhookUrl];
      if (url == null || url.isEmpty) return false;

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      await ErrorLogService.log('WebhookService.dispatch', e);
      return false;
    }
  }
}
