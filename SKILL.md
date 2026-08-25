# Meko — Technical Specification

## 1. Executive Summary & Core Context

- **App Name:** Meko
- **Primary Objective:** Vehicle telemetry, diagnostic scanning, and real-time sensor monitoring using an OBD2 adapter.
- **Target Platforms:** Android & iOS (cross-platform Flutter codebase).
- **Hardware Setup:**
  - Vehicle OBD2 port → physical extension cord → Vgate iCar Pro adapter.
  - Vgate iCar Pro adapter → wireless Bluetooth Low Energy (BLE) → mobile device.

---

## 2. Tech Stack & Dependencies

The codebase must adhere strictly to these core packages:

| Category | Package / Tool | Version Constraint | Purpose |
| :--- | :--- | :--- | :--- |
| **Framework** | Flutter (Dart) | Latest Stable | Cross-platform UI & state management |
| **Backend** | Supabase | Current SDK | Authentication (Magic Link) & database operations |
| **Bluetooth** | `flutter_blue_plus` | `^1.32.0` | Exclusive BLE communication engine |
| **Environment** | `flutter_dotenv` | Latest | Secure management of `.env` variables |
| **Integration** | `http` | Latest | External webhook dispatches (e.g., Make.com) |

---

## 3. Environment & Configuration

The project root must contain a `.env` file. Generate a template with dummy variables during initial setup:

```env
SUPABASE_URL=https://your-supabase-project-id.supabase.co
SUPABASE_ANON_KEY=your_supabase_anon_key_here
MAKE_WEBHOOK_URL=https://hook.us1.make.com/your_webhook_id_here
```

---

## 4. Backend & Error Handling Protocol

### Supabase Table Schema: `error_logs`

**Table Name:** `error_logs`

**Columns:**

- `id` (uuid, Default: `gen_random_uuid()`)
- `created_at` (timestamp with time zone, Default: `now()`)
- `log` (text)

### Critical Exception Logging Rule

Every `catch (e)` block across custom services and Bluetooth routines MUST log errors directly to Supabase without interrupting the user experience or crashing the app.

```dart
try {
  // Primary operational code
} catch (e) {
  // 1. Console print for local debugging
  print("Execution Error: $e");

  // 2. Isolated Supabase error logging
  try {
    await SupaFlow.client.from('error_logs').insert({
      'log': 'MethodName failed: ${e.toString()}',
    });
  } catch (_) {
    // Fail silently if network connection is unavailable
  }

  // 3. Graceful fallback
  return false;
}
```

---

## 5. Bluetooth Low Energy (BLE) Engine & Constraints

### Hardware & Protocol Realities

- **Dual-Mode Filtering:** The Vgate iCar Pro broadcasts two signals:
  - `Android-Vlink` (Bluetooth 3.0 Classic — **DO NOT USE**)
  - `IOS-Vlink` (Bluetooth 4.0 BLE — **TARGET DEVICE**)
- **Package Rule:** `flutter_blue_plus` is strictly a BLE library. The scanner MUST filter out any Classic Bluetooth endpoints.

### Case-Insensitive Scanning Filter

Incoming device names must be converted to lowercase (`.toLowerCase()`) prior to applying logic:

```dart
String name = r.device.platformName.toLowerCase();
String advName = r.advertisementData.advName.toLowerCase();

// Target BLE signals while strictly ignoring Classic Bluetooth endpoints
if ((name.contains('vgate') || advName.contains('vgate') ||
     name.contains('ios-vlink') || advName.contains('ios-vlink')) &&
    !name.contains('android') && !advName.contains('android')) {
  targetDevice = r.device;
  deviceFound = true;
  await FlutterBluePlus.stopScan();
  break;
}
```

### System Handshake Execution Rules

- **Runtime Permissions:** Explicitly request Android Bluetooth and Nearby Devices permissions prior to triggering scan operations.
- **OS Buffer Delay:** Implement a mandatory 1000ms delay immediately following permission approval to allow the native OS Bluetooth stack time to initialize.
- **Scan Timeout:** 10 seconds.
- **Connection Timeout:** 15 seconds.
- **Method Signature:** NEVER pass a `license:` parameter to `.connect()`. Use `await targetDevice.connect(timeout: const Duration(seconds: 15));`.
- **Native Settings Rule:** Devices must NOT be paired in native phone OS Bluetooth settings. The app handles connection directly.

---

## 6. Page Action Graph & UI Failure State Rules

### Handshake Page Load Flow (`Bluetooth_handshake`)

```
[Page Load]
   └── Request Permissions (Bluetooth / Nearby Devices)
        └── Wait 1000ms (Buffer Delay)
             └── Custom Action: connectToVgateAdapter
                  └── Check: btSuccess == true
                       ├── TRUE  => Update Page State & Start Data Stream
                       └── FALSE => Display Alert Dialog ("Connection Failed")
```

### UI Failure Protocol (Crucial)

- **No Auto-Navigate:** On connection failure (FALSE branch), display an Alert Dialog but DO NOT trigger a Navigate Back or page pop action.
- **Retry Capability:** The user must remain on the `Bluetooth_handshake` screen with an active "Retry Connection" button that re-executes the handshake flow on tap.

---

## 7. Agent Execution & Ingestion Instructions

- **Scaffold Architecture:** Initialize a clean Flutter directory structure:
  - `lib/core/` (constants, themes, utils)
  - `lib/services/` (supabase, bluetooth, webhooks)
  - `lib/models/` (telemetry data models)
  - `lib/views/` (screens and widget trees)
- **Confirm Ingestion Directory:** Ask the user to place UI screenshots into `assets/mockups/`.
- **Screen Replication:** Scan the provided mockup screenshots visually and build identical responsive Flutter layouts using Material 3 guidelines.
