/// Severity levels for OBD2 diagnostic fault codes.
enum FaultSeverity {
  high,
  medium,
  low;

  String get label {
    switch (this) {
      case FaultSeverity.high:
        return 'Critical';
      case FaultSeverity.medium:
        return 'Medium';
      case FaultSeverity.low:
        return 'Low';
    }
  }
}

/// Data model for an OBD2 diagnostic fault code.
///
/// Represents a single DTC (Diagnostic Trouble Code) with its metadata,
/// human-readable description, symptoms, and consequences.
class Fault {
  const Fault({
    required this.code,
    required this.name,
    required this.severity,
    this.description = '',
    this.symptoms = const [],
    this.consequences = const [],
  });

  /// OBD2 code, e.g. "P0320", "P0230".
  final String code;

  /// Human-readable name, e.g. "Cylinder misfire", "FUEL PUMP MALFUNCTION".
  final String name;

  /// Severity classification.
  final FaultSeverity severity;

  /// Detailed description of the fault.
  final String description;

  /// List of symptoms the driver may experience.
  final List<String> symptoms;

  /// List of potential consequences if not addressed.
  final List<String> consequences;

  /// Construct from a Supabase JSON row.
  factory Fault.fromJson(Map<String, dynamic> json) {
    return Fault(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      severity: _parseSeverity(json['severity'] as String?),
      description: json['description'] as String? ?? '',
      symptoms: _parseStringList(json['symptoms']),
      consequences: _parseStringList(json['consequences']),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'severity': severity.name,
        'description': description,
        'symptoms': symptoms,
        'consequences': consequences,
      };

  static FaultSeverity _parseSeverity(String? value) {
    switch (value?.toLowerCase()) {
      case 'high':
      case 'critical':
        return FaultSeverity.high;
      case 'medium':
        return FaultSeverity.medium;
      case 'low':
        return FaultSeverity.low;
      default:
        return FaultSeverity.medium;
    }
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }
}
