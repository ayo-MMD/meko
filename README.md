# Meko

Vehicle telemetry, diagnostic scanning, and real-time sensor monitoring via OBD2/BLE — built with Flutter.

## Architecture

```
lib/
├── main.dart                        # Entry point (dotenv + Supabase init)
├── app.dart                         # Root MaterialApp (Material 3)
├── core/                            # Configuration & shared foundations
│   ├── constants.dart               # BLE timeouts, table names
│   ├── env_config.dart              # .env key definitions
│   └── exceptions.dart              # Base MekoException class
├── models/                          # Data models (telemetry, DB entities)
├── services/                        # External integrations
│   ├── bluetooth_service.dart       # Vgate iCar Pro BLE engine
│   ├── error_log_service.dart       # Supabase error_logs writer
│   ├── supabase_service.dart        # Supabase SDK initialiser
│   └── webhook_service.dart         # Make.com HTTP dispatcher
├── providers/                       # State management / business logic
├── routing/                         # Navigation configuration
├── ui/                              # Shared UI components
│   ├── theme/meko_theme.dart        # Light/dark theme definitions
│   └── widgets/                     # Reusable widget library
├── utils/                           # Helpers, formatters, extensions
└── views/                           # Feature screens (one dir per screen)

assets/
└── mockups/                         # UI design screenshots (user-provided)
```

## Getting Started

1. Copy `.env.example` to `.env` and fill in your real credentials.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to launch the app.

## Environment Variables

| Variable | Description |
|---|---|
| `SUPABASE_URL` | Your Supabase project URL |
| `SUPABASE_ANON_KEY` | Supabase anonymous/public key |
| `MAKE_WEBHOOK_URL` | Make.com webhook endpoint URL |

## Tech Stack

| Category | Package | Purpose |
|---|---|---|
| Framework | Flutter (Dart) | Cross-platform UI |
| Backend | `supabase_flutter` | Auth (Magic Link) & DB |
| Bluetooth | `flutter_blue_plus` ^1.32.0 | BLE communication |
| Environment | `flutter_dotenv` | .env variable management |
| Integration | `http` | Webhook dispatches |
| Permissions | `permission_handler` | Runtime BLE permissions |
