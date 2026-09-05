/// Shared Postgres enum types mapped to Dart.
///
/// Each enum corresponds to a `USER-DEFINED` type in the Supabase schema.
/// All enums include a safe [fromString] factory and a [toJson] getter
/// for reliable DB ↔ Dart mapping.
library;
// ---------------------------------------------------------------------------
// profile_status — user.status
// ---------------------------------------------------------------------------

enum ProfileStatus {
  active,
  inactive;

  static ProfileStatus fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'ACTIVE':
        return ProfileStatus.active;
      case 'INACTIVE':
        return ProfileStatus.inactive;
      default:
        return ProfileStatus.inactive;
    }
  }

  String get toJson => name.toUpperCase();

  String get label {
    switch (this) {
      case ProfileStatus.active:
        return 'Active';
      case ProfileStatus.inactive:
        return 'Inactive';
    }
  }
}

// ---------------------------------------------------------------------------
// connection_type — vehicle.connection_type
// ---------------------------------------------------------------------------

enum ConnectionType {
  none,
  vgate,
  smartcar;

  static ConnectionType fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'VGATE':
        return ConnectionType.vgate;
      case 'SMARTCAR':
        return ConnectionType.smartcar;
      case 'NONE':
      default:
        return ConnectionType.none;
    }
  }

  String get toJson => name.toUpperCase();

  String get label {
    switch (this) {
      case ConnectionType.none:
        return 'None';
      case ConnectionType.vgate:
        return 'Vgate Adapter';
      case ConnectionType.smartcar:
        return 'Smartcar';
    }
  }
}

// ---------------------------------------------------------------------------
// billing_type — mechanic_settings.billing_type
// ---------------------------------------------------------------------------

enum BillingType {
  fixed,
  percentage;

  static BillingType fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'FIXED':
        return BillingType.fixed;
      case 'PERCENTAGE':
        return BillingType.percentage;
      default:
        return BillingType.fixed;
    }
  }

  String get toJson => name.toUpperCase();
}

// ---------------------------------------------------------------------------
// frequency — mechanic_settings.frequency, subscription.frequency
// ---------------------------------------------------------------------------

enum Frequency {
  weekly,
  monthly,
  yearly;

  static Frequency fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'WEEKLY':
        return Frequency.weekly;
      case 'MONTHLY':
        return Frequency.monthly;
      case 'YEARLY':
        return Frequency.yearly;
      default:
        return Frequency.monthly;
    }
  }

  String get toJson => name.toUpperCase();

  String get label {
    switch (this) {
      case Frequency.weekly:
        return 'Weekly';
      case Frequency.monthly:
        return 'Monthly';
      case Frequency.yearly:
        return 'Yearly';
    }
  }
}

// ---------------------------------------------------------------------------
// notification_severity — notification.severity
// ---------------------------------------------------------------------------

enum NotificationSeverity {
  high,
  medium,
  low;

  static NotificationSeverity fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'HIGH':
        return NotificationSeverity.high;
      case 'MEDIUM':
        return NotificationSeverity.medium;
      case 'LOW':
        return NotificationSeverity.low;
      default:
        return NotificationSeverity.medium;
    }
  }

  String get toJson => name.toUpperCase();

  String get label {
    switch (this) {
      case NotificationSeverity.high:
        return 'Critical';
      case NotificationSeverity.medium:
        return 'Medium';
      case NotificationSeverity.low:
        return 'Low';
    }
  }
}

// ---------------------------------------------------------------------------
// notification_status — notification.status
// ---------------------------------------------------------------------------

enum NotificationStatus {
  active,
  resolved;

  static NotificationStatus fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'ACTIVE':
        return NotificationStatus.active;
      case 'RESOLVED':
        return NotificationStatus.resolved;
      default:
        return NotificationStatus.active;
    }
  }

  String get toJson => name.toUpperCase();

  String get label {
    switch (this) {
      case NotificationStatus.active:
        return 'Active';
      case NotificationStatus.resolved:
        return 'Resolved';
    }
  }
}

// ---------------------------------------------------------------------------
// transaction_status — transaction.status
// ---------------------------------------------------------------------------

enum TransactionStatus {
  pending,
  success,
  failed;

  static TransactionStatus fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'PENDING':
        return TransactionStatus.pending;
      case 'SUCCESS':
        return TransactionStatus.success;
      case 'FAILED':
        return TransactionStatus.failed;
      default:
        return TransactionStatus.pending;
    }
  }

  String get toJson => name.toUpperCase();
}

// ---------------------------------------------------------------------------
// transaction_entry — transaction.entry
// ---------------------------------------------------------------------------

enum TransactionEntry {
  credit,
  debit;

  static TransactionEntry fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'CREDIT':
        return TransactionEntry.credit;
      case 'DEBIT':
        return TransactionEntry.debit;
      default:
        return TransactionEntry.credit;
    }
  }

  String get toJson => name.toUpperCase();
}

// ---------------------------------------------------------------------------
// transaction_channel — transaction.channel
// ---------------------------------------------------------------------------

enum TransactionChannel {
  card,
  transfer,
  wallet;

  static TransactionChannel fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'CARD':
        return TransactionChannel.card;
      case 'TRANSFER':
        return TransactionChannel.transfer;
      case 'WALLET':
        return TransactionChannel.wallet;
      default:
        return TransactionChannel.card;
    }
  }

  String get toJson => name.toUpperCase();
}
