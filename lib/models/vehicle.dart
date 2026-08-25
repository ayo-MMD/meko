/// Data model for a connected vehicle.
///
/// Stores identifying info and sync metadata displayed on
/// the Home and Settings screens.
class Vehicle {
  const Vehicle({
    required this.name,
    required this.vin,
    this.imageUrl,
    this.lastSynced,
  });

  /// Display name, e.g. "2013 Toyota Avalon".
  final String name;

  /// Vehicle Identification Number.
  final String vin;

  /// Optional URL for a vehicle image.
  final String? imageUrl;

  /// Timestamp of last data sync.
  final DateTime? lastSynced;

  /// Construct from a Supabase JSON row.
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      name: json['name'] as String? ?? '',
      vin: json['vin'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      lastSynced: json['last_synced'] != null
          ? DateTime.tryParse(json['last_synced'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'vin': vin,
        'image_url': imageUrl,
        'last_synced': lastSynced?.toIso8601String(),
      };

  /// Human-readable "X minutes ago" string for last sync time.
  String get lastSyncedLabel {
    if (lastSynced == null) return 'Never synced';
    final diff = DateTime.now().difference(lastSynced!);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return 'Last synced:${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return 'Last synced:${diff.inHours} hours ago';
    return 'Last synced:${diff.inDays} days ago';
  }
}
